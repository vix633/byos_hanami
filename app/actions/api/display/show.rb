# frozen_string_literal: true

require "dry/monads"
require "initable"
require "trmnl/api"

module Terminus
  module Actions
    module API
      module Display
        # The show action.
        class Show < Base
          include Deps[
            :settings,
            "aspects.screens.encoder",
            "aspects.screens.rotator",
            firmware_repository: "repositories.firmware",
            synchronizer: "aspects.devices.synchronizer"
          ]

          include Initable[model: TRMNL::API::Models::Display]
          include Dry::Monads[:result]

          using Refines::Actions::Response

          def handle request, response
            case process request.env, request.params
              in Success(payload) then response.with body: payload.to_json, status: 200
              in Failure(String => detail) then unprocessable_entity detail, response
              else not_found response
            end
          end

          private

          def process environment, parameters
            cached_device = nil

            synchronizer.call(environment)
                        .bind { |device| cached_device = device and rotator.call device }
                        .bind { |screen| encode screen, environment, parameters }
                        .fmap { |image_attributes| build_payload cached_device, image_attributes }
          end

          def build_payload device, image_attributes
            model[
              firmware_url: fetch_firmware_uri(device),
              **image_attributes,
              **device.as_api_display
            ]
          end

          # :reek:FeatureEnvy
          def fetch_firmware_uri device
            firmware_repository.latest.then do |firmware|
              break unless firmware
              break if device.firmware_version == firmware.version

              firmware.attachment_uri host: settings.api_uri
            end
          end

          def encode screen, environment, parameters
            encryption = :base_64 if (environment["HTTP_BASE64"] || parameters[:base_64]) == "true"
            encoder.call screen, encryption:
          end

          def unprocessable_entity detail, response
            body = problem[
              type: "/problem_details#device",
              status: __method__,
              detail:,
              instance: "/api/display"
            ]

            response.with body: body.to_json, format: :problem_details, status: 422
          end

          def not_found response
            body = problem[
              type: "/problem_details#device_id",
              status: __method__,
              detail: "Invalid device ID.",
              instance: "/api/display"
            ]

            response.with body: body.to_json, format: :problem_details, status: 404
          end
        end
      end
    end
  end
end
