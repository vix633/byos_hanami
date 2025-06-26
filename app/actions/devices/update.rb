# frozen_string_literal: true

require "initable"

module Terminus
  module Actions
    module Devices
      # The update action.
      class Update < Terminus::Action
        include Deps[
          repository: "repositories.device",
          show_view: "views.devices.show",
          edit_view: "views.devices.edit"
        ]

        include Initable[model_optioner: proc { Terminus::Aspects::Models::Optioner }]

        contract Contracts::Devices::Update

        def handle request, response
          parameters = request.params
          device = repository.find parameters[:id]

          halt :unprocessable_entity unless device

          if parameters.valid?
            save device, parameters, response
          else
            edit device, parameters, response
          end
        end

        private

        def save device, parameters, response
          id = device.id
          repository.update id, **parameters[:device]

          response.render show_view,
                          model_options: model_optioner.call,
                          device: repository.find(id),
                          layout: false
        end

        def edit device, parameters, response
          response.render edit_view,
                          model_options: model_optioner.call,
                          device:,
                          fields: parameters[:device],
                          errors: parameters.errors[:device],
                          layout: false
        end
      end
    end
  end
end
