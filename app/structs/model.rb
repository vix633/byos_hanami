# frozen_string_literal: true

module Terminus
  module Structs
    # The model struct.
    class Model < DB::Struct
      def dimensions = "#{width}x#{height}"
    end
  end
end
