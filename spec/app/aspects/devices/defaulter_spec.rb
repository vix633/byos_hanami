# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Aspects::Devices::Defaulter do
  subject(:builder) { described_class.new randomizer: }

  let :randomizer do
    class_double SecureRandom, hex: "abc123", alphanumeric: "Ov2tWq4XoYCH2xPfiZqc"
  end

  describe "#call" do
    it "answers defaults" do
      expect(builder.call).to eq(
        label: "TRMNL",
        friendly_id: "ABC123",
        api_key: "Ov2tWq4XoYCH2xPfiZqc",
        refresh_rate: 900,
        image_timeout: 0
      )
    end
  end
end
