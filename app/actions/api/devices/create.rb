# frozen_string_literal: true

require "initable"

module Terminus
  module Actions
    module API
      module Devices
        # The create action.
        class Create < Base
          include Deps["aspects.devices.defaulter", repository: "repositories.device"]
          include Initable[serializer: Serializers::Device]

          using Refines::Actions::Response

          contract Contracts::Devices::Create

          def handle request, response
            parameters = request.params

            if parameters.valid?
              device = repository.create defaulter.call.merge(parameters[:device])
              response.body = {data: serializer.new(device).to_h}.to_json
            else
              unprocessable_entity parameters, response
            end
          end

          private

          def unprocessable_entity parameters, response
            body = problem[
              type: "/problem_details#device_payload",
              status: :unprocessable_entity,
              detail: "Validation failed.",
              instance: "/api/devices",
              extensions: {errors: parameters.errors.to_h}
            ]

            response.with body: body.to_json, format: :problem_details, status: 422
          end
        end
      end
    end
  end
end
