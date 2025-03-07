# frozen_string_literal: true

module Terminus
  module Actions
    module Devices
      # The create action.
      class Create < Terminus::Action
        include Deps[
          repository: "repositories.device",
          new_view: "views.devices.new",
          show_view: "views.devices.show"
        ]

        params do
          required(:device).hash do
            required(:label).filled :string
            required(:mac_address).filled :string
            required(:refresh_rate).filled :integer
          end
        end

        def handle request, response
          parameters = request.params

          if parameters.valid?
            device = repository.create parameters[:device]
            response.render show_view, device: repository.find(device.id)
          else
            response.render new_view, errors: parameters.errors[:device]
          end
        end
      end
    end
  end
end
