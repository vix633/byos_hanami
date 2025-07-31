# frozen_string_literal: true

require "pipeable"

module Terminus
  module Aspects
    module Firmware
      # Parses firmware HTTP headers.
      class Header
        include Pipeable

        def initialize contract: Terminus::Contracts::Firmware::Header,
                       model: Terminus::Models::Firmware::Header
          @contract = contract
          @model = model
        end

        def call(headers) = pipe headers, validate(contract, as: :to_h), to(model, :for)

        private

        attr_reader :contract, :model
      end
    end
  end
end
