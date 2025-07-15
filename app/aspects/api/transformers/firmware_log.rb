# frozen_string_literal: true

require "dry/core"
require "initable"
require "refinements/hash"

module Terminus
  module Aspects
    module API
      module Transformers
        # Transforms raw firmware log into attributes fit for creating a device log record.
        class FirmwareLog
          include Initable[key_map: {id: :external_id}.freeze]

          using Refinements::Hash

          def call payload
            payload.fetch(:logs, Dry::Core::EMPTY_HASH).map do |item|
              item.transform_keys!(key_map).transform_value!(:created_at) { Time.at it }
            end
          end
        end
      end
    end
  end
end
