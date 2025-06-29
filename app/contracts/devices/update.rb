# frozen_string_literal: true

module Terminus
  module Contracts
    module Devices
      # The contract for device updates.
      class Update < Dry::Validation::Contract
        params do
          required(:id).filled :integer
          required(:device).hash Schemas::Devices::Upsert
        end

        rule device: :sleep_start_at, &Rules::SleepStartAt
        rule device: :sleep_stop_at, &Rules::SleepStopAt
      end
    end
  end
end
