# frozen_string_literal: true

module Terminus
  module Contracts
    module Devices
      # The contract for device patches.
      class Patch < Dry::Validation::Contract
        params do
          required(:id).filled :integer
          required(:device).hash Schemas::Devices::Patch
        end

        rule device: :sleep_start_at, &Rules::SleepStartAt
        rule device: :sleep_stop_at, &Rules::SleepStopAt
      end
    end
  end
end
