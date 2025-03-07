# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Images::Fetcher do
  using Refinements::Pathname

  subject(:fetcher) { described_class.new }

  include_context "with temporary directory"

  describe "#call" do
    let(:fixture_path) { SPEC_ROOT.join "support/fixtures/test.bmp" }
    let(:images_uri) { "https://localhost/assets/images" }

    it "answers default image" do
      expect(fetcher.call(images_uri:)).to eq(
        filename: "empty_state",
        image_url: "https://localhost/assets/images/setup/logo.bmp"
      )
    end

    it "answers generated image without encryption" do
      path = temp_dir.join("public/images/generated").mkpath.join("test.bmp")
      fixture_path.copy path

      expect(fetcher.call(path.parent, images_uri:)).to eq(
        filename: "test.bmp",
        image_url: "https://localhost/assets/images/generated/test.bmp"
      )
    end

    it "answers generated image with encryption" do
      path = temp_dir.join("public/images/generated").mkpath.join("test.bmp")
      fixture_path.copy path

      expect(fetcher.call(path.parent, images_uri:, encryption: :base_64)).to match(
        filename: "test.bmp",
        image_url: %r(data:image/bmp;base64,.+)
      )
    end

    it "answers generated image without encryption when given invalid encryption" do
      path = temp_dir.join("public/images/generated").mkpath.join("test.bmp")
      fixture_path.copy path

      expect(fetcher.call(path.parent, images_uri:, encryption: :bogus)).to eq(
        filename: "test.bmp",
        image_url: "https://localhost/assets/images/generated/test.bmp"
      )
    end
  end
end
