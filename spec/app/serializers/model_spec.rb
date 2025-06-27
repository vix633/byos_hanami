# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Serializers::Model, :db do
  subject(:serializer) { described_class.new model }

  let(:model) { Factory[:model, **attributes] }

  let :attributes do
    {
      name: "t1",
      label: "T1",
      description: nil,
      width: 800,
      height: 480,
      published_at: "2025-01-01T00:00:00+0000"
    }
  end

  describe "#to_h" do
    it "answers explicit hash" do
      expect(serializer.to_h).to eq(id: model.id, **attributes)
    end
  end
end
