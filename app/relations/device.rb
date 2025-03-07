# frozen_string_literal: true

module Terminus
  module Relations
    # The device relation.
    class Device < DB::Relation
      schema :devices, infer: true
    end
  end
end
