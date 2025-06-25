# frozen_string_literal: true

module Terminus
  module Actions
    module API
      module Models
        # The delete action.
        class Delete < Base
          include Deps[repository: "repositories.model"]

          def handle request, response
            model = repository.delete request.params[:id]
            response.body = {data: model.to_h}.to_json
          end
        end
      end
    end
  end
end
