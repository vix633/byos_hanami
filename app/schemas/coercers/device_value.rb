# auto_register: false
# frozen_string_literal: true

require "dry/schema"

module Terminus
  module Schemas
    module Coercers
      DeviceValue = lambda do |result|
        return unless result.output

        attributes = result.to_h

        attributes[:proxy] = false unless result.key? :proxy
        attributes[:firmware_beta] = false unless result.key? :firmware_beta
        attributes[:firmware_update] = false unless result.key? :firmware_update

        attributes
      end
    end
  end
end
