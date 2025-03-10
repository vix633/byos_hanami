# frozen_string_literal: true

module Terminus
  module Actions
    module API
      module Setup
        # The show action.
        class Show < Terminus::Action
          include Deps[repository: "repositories.device"]

          using Refines::Actions::Response

          format :json

          def initialize(model: Models::API::Responses::Setup, **)
            @model = model
            super(**)
          end

          def handle request, response
            device = repository.find_by_mac_address request.env["HTTP_ID"]

            if device
              response.body = model.for(device).to_json
            else
              response.with body: model.new.to_json, status: 404
            end
          end

          private

          attr_reader :model
        end
      end
    end
  end
end
