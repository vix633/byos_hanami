# frozen_string_literal: true

module Terminus
  module Actions
    module API
      module Log
        # The create action.
        class Create < Terminus::Action
          include Deps[:logger]

          KEYS = %w[
            SERVER_SOFTWARE
            SERVER_NAME
            SERVER_PORT
            HTTP_BASE64
            HTTP_FW_VERSION
            HTTP_ACCESS_TOKEN
            HTTP_HEIGHT
            HTTP_HOST
            HTTP_ID
            HTTP_REFRESH_RATE
            HTTP_USER_AGENT
            HTTP_WIDTH
            REQUEST_METHOD
            REQUEST_PATH
            REQUEST_URI
            QUERY_STRING
            PATH_INFO
          ].freeze

          format :json

          def handle request, response
            logger.info(**request.env.slice(*KEYS))
            response.status = 204
          end
        end
      end
    end
  end
end
