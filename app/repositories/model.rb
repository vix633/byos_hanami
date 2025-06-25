# frozen_string_literal: true

module Terminus
  module Repositories
    # The model repository.
    class Model < DB::Repository[:model]
      commands :create, update: :by_pk, delete: :by_pk

      def all
        model.order { published_at.asc }
             .to_a
      end

      def find(id) = (model.by_pk(id).one if id)

      def find_by(**) = model.where(**).first

      def find_or_create(key, value, **)
        model.where(key => value).one.then { |record| record || create(name: value, **) }
      end
    end
  end
end
