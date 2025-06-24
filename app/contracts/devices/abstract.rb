# frozen_string_literal: true

module Terminus
  module Contracts
    module Devices
      # The abstract contract for device create and update.
      class Abstract < Dry::Validation::Contract
        rule device: :sleep_start_at do
          stop_at = values.dig :device, :sleep_stop_at

          if value && stop_at && value > stop_at then key.failure "must be before stop time"
          elsif value && stop_at.nil? then key.failure "must have corresponding stop time"
          elsif value.nil? && stop_at then key.failure "must be filled"
          else next
          end
        end

        rule device: :sleep_stop_at do
          start_at = values.dig :device, :sleep_start_at

          if value && start_at && value < start_at then key.failure "must be after start time"
          elsif value && start_at.nil? then key.failure "must have corresponding start time"
          elsif value.nil? && start_at then key.failure "must be filled"
          else next
          end
        end
      end
    end
  end
end
