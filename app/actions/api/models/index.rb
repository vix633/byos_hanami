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
            response.body = {data:}.to_json
          end

          private

          def data
            repository.all.map do |record|
              record.attributes.slice :id,
                                      :name,
                                      :label,
                                      :description,
                                      :width,
                                      :height,
                                      :published_at
            end
          end
        end
      end
    end
  end
end
