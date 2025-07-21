# frozen_string_literal: true

module Terminus
  module Actions
    module Devices
      # The new action.
      class New < Terminus::Action
        include Deps[:htmx, "aspects.devices.builder", model_repository: "repositories.model"]

        def handle request, response
          view_settings = {models: model_repository.all, fields: builder.call}
          view_settings[:layout] = false if htmx.request(**request.env).request?

          response.render view, **view_settings
        end
      end
    end
  end
end
