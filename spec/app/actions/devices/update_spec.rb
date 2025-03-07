# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Actions::Devices::Update, :db do
  subject(:action) { described_class.new }

  describe "#call" do
    let(:device) { Factory[:device] }

    it "answers success when there are no validation errors" do
      device
      response = action.call id: device.id, device: {label: "Test Update"}
      expect(response.status).to eq(200)
    end

    it "answers errors when fields are missing" do
      response = action.call id: device.id, device: {label: ""}
      expect(response.body.to_s).to include("label must be filled")
    end
  end
end
