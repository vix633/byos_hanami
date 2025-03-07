# frozen_string_literal: true

require "securerandom"

module Terminus
  module Images
    Randomizer = proc { SecureRandom.uuid }
  end
end
