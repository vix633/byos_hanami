# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Actions::Devices::Index do
  subject(:action) { described_class.new }

  describe "#call" do
    it "renders index" do
      response = action.call Hash.new
      expect(response.status).to eq(200)
    end
  end
end
