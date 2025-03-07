# frozen_string_literal: true

require "refinements/pathname"

module Terminus
  # Touches the oldest file to make it the latest file.
  module Images
    using Refinements::Pathname

    Toucher = -> root { Pathname(root).files.min_by(&:ctime).touch }
  end
end
