# frozen_string_literal: true

module Terminus
  module Actions
    module Designer
      # The create action.
      class Create < Terminus::Action
        include Deps[
          :htmx,
          "aspects.screens.creator",
          model_repository: "repositories.model",
          screen_repository: "repositories.screen",
          show_view: "views.designer.show"
        ]

        using Refines::Actions::Response

        params do
          required(:template).filled(:hash) do
            required(:id).filled :string
            required(:content).filled :string
          end
        end

        def handle request, response
          parameters = request.params

          halt 422 unless parameters.valid?

          if htmx.request(**request.env).request?
            render_text parameters[:template], response
          else
            response.render show_view, id: Time.new.utc.to_i
          end
        end

        private

        def render_text template, response
          id, content = template.values_at :id, :content

          rebuild_screen id, content
          response.with body: content.strip, status: 201
        end

        def rebuild_screen name, content
          screen_repository.find_by(name:).then { screen_repository.delete it.id if it }
          creator.call model_id: load_model.id, label: name.capitalize, name: name, content:
        end

        # FIX: Use dynamic lookup once the UI support picking the correct model.
        def load_model = model_repository.find_by name: "og_png"
      end
    end
  end
end
