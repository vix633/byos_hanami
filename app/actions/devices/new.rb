# frozen_string_literal: true

require "initable"

module Terminus
  module Actions
    module Devices
      # The new action.
      class New < Terminus::Action
        include Deps["aspects.devices.builder"]
        include Initable[model_optioner: proc { Terminus::Aspects::Models::Optioner }]

        def handle request, response
          view_settings = {model_options: model_optioner.call, fields: builder.call}
          view_settings[:layout] = false if request.env.key? "HTTP_HX_REQUEST"

          response.render view, **view_settings
        end
      end
    end
  end
end
