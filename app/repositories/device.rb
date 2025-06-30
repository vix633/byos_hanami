# frozen_string_literal: true

module Terminus
  module Repositories
    # The device repository.
    class Device < DB::Repository[:devices]
      commands :create, update: :by_pk, delete: :by_pk

      def all
        with_associations.order { created_at.asc }
                         .to_a
      end

      def all_by_label value
        with_associations.where { label.ilike "%#{value}%" }
                         .order { created_at.asc }
                         .to_a
      end

      def find(id) = (with_associations.by_pk(id).one if id)

      def find_by_api_key(value) = with_associations.where(api_key: value.to_s).one

      def find_by_mac_address(value) = with_associations.where(mac_address: value.to_s).one

      def update_by_mac_address(value, **attributes)
        device = find_by_mac_address value

        return device if attributes.empty?
        return unless device

        update device.id, **attributes
      end

      private

      def with_associations = devices.combine :model, :playlist
    end
  end
end
