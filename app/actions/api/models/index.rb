# frozen_string_literal: true

module Terminus
  module Actions
    module API
      module Models
        # The index action.
        class Index < Hanami::Action
          include Deps[repository: "repositories.model"]

          format :json

          def handle *, response
            response.body = {data: repository.all.map(&:to_h)}.to_json
          end
        end
      end
    end
  end
end
