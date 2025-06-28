# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Schemas::Coercers::DeviceValue do
  subject(:coercer) { described_class }

  let(:attributes) { {proxy: true, firmware_beta: true, firmware_update: true} }

  let :result do
    Dry::Schema::Result.new(attributes, message_compiler: proc { Hash.new }, result_ast: [])
  end

  describe "#call" do
    it "answers original attributes when present" do
      expect(coercer.call(result)).to eq(firmware_beta: true, firmware_update: true, proxy: true)
    end

    it "answers false when firmware beta key is missing" do
      attributes.delete :firmware_beta
      expect(coercer.call(result)).to include(firmware_beta: false)
    end

    it "answers false when firmware update key is missing" do
      attributes.delete :firmware_update
      expect(coercer.call(result)).to include(firmware_update: false)
    end

    it "answers false when proxy key is missing" do
      attributes.delete :proxy
      expect(coercer.call(result)).to include(proxy: false)
    end
  end
end
