# frozen_string_literal: true

require "initable"

module Terminus
  module Actions
    module Devices
      # The create action.
      class Create < Terminus::Action
        include Deps[
          :htmx,
          repository: "repositories.device",
          new_view: "views.devices.new",
          index_view: "views.devices.index"
        ]

        include Initable[model_optioner: proc { Terminus::Aspects::Models::Optioner }]

        contract Contracts::Devices::Create

        def handle request, response
          parameters = request.params

          if parameters.valid?
            repository.create parameters[:device]
            response.render index_view, **view_settings(request, parameters)
          else
            render_new response, parameters
          end
        end

        private

        def view_settings request, _parameters
          settings = {devices: repository.all}
          settings[:layout] = false if htmx.request(**request.env).request?
          settings
        end

        def render_new response, parameters
          response.render new_view,
                          model_options: model_optioner.call,
                          device: nil,
                          fields: parameters[:device],
                          errors: parameters.errors[:device],
                          layout: false
        end
      end
    end
  end
end
