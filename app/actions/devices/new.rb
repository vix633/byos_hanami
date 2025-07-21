# frozen_string_literal: true

require "initable"

module Terminus
  module Actions
    module Devices
      # The new action.
      class New < Terminus::Action
        include Deps[:htmx, "aspects.devices.builder"]
        include Initable[model_optioner: proc { Terminus::Aspects::Models::Optioner }]

        def handle request, response
          view_settings = {model_options: model_optioner.call, fields: builder.call}
          view_settings[:layout] = false if htmx.request(**request.env).request?

          response.render view, **view_settings
        end
      end
    end
  end
end
