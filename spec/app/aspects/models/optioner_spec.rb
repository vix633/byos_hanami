# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Aspects::Models::Optioner, :db do
  subject(:optioner) { described_class }

  describe "#call" do
    let(:model) { Factory[:model] }

    it "answers options with prompt" do
      model
      expect(optioner.call).to eq([["Select...", nil], [model.label, model.id]])
    end

    it "answers options without prompt" do
      model
      expect(optioner.call(nil)).to eq([[model.label, model.id]])
    end

    it "answers empty array when records don't exist" do
      expect(optioner.call).to eq([])
    end
  end
end
