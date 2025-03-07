# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Images::Rotator do
  using Refinements::Pathname

  subject(:rotator) { described_class.new }

  include_context "with temporary directory"

  describe "#call" do
    let(:images_uri) { "https://test.io/images" }

    it "answers oldest image as newest image" do
      temp_dir.join("one.bmp").touch
      temp_dir.join("two.bmp").touch

      expect(rotator.call(temp_dir, images_uri:)).to eq(
        filename: "one.bmp",
        image_url: "https://test.io/images/generated/one.bmp"
      )
    end

    it "answers oldest image as newest image with encryption" do
      temp_dir.join("one.bmp").touch
      temp_dir.join("two.bmp").touch

      expect(rotator.call(temp_dir, images_uri:, encryption: :base_64)).to eq(
        filename: "one.bmp",
        image_url: "data:image/bmp;base64,"
      )
    end
  end
end
