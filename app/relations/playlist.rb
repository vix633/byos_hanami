# frozen_string_literal: true

module Terminus
  module Relations
    # The playlist relation.
    class Playlist < DB::Relation
      schema :playlist, infer: true do
        associations { has_many :devices }
      end
    end
  end
end
