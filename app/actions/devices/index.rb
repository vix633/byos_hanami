# frozen_string_literal: true

module Terminus
  module Actions
    module Devices
      # The index action.
      class Index < Terminus::Action
        include Deps[:htmx, repository: "repositories.device"]

        def handle request, response
          query = request.params[:query].to_s
          devices = load_devices query

          if htmx.request(**request.env).trigger == "search"
            add_htmx_headers response, query
            response.render view, devices:, query:, layout: false
          else
            response.render view, devices:, query:
          end
        end

        private

        def load_devices query
          query.empty? ? repository.all : repository.all_by(label: query)
        end

        def add_htmx_headers response, query
          return if query.empty?

          response.headers["HX-Push-Url"] = routes.path :devices, query:
        end
      end
    end
  end
end
