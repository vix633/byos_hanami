# frozen_string_literal: true

module Terminus
  module Repositories
    # The playlist repository.
    class Playlist < DB::Repository[:playlist]
      commands :create, update: :by_pk, delete: :by_pk

      def all
        playlist.order { created_at.asc }
                .to_a
      end

      def all_by(**)
        playlist.where(**)
                .order { created_at.asc }
                .to_a
      end

      def find(id) = (playlist.by_pk(id).one if id)

      def find_by(**) = playlist.where(**).one
    end
  end
end
