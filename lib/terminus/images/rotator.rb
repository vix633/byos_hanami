# frozen_string_literal: true

module Terminus
  module Images
    # Rotates and fetches images for rendering on a device.
    class Rotator
      def initialize toucher: Toucher, fetcher: Fetcher.new
        @toucher = toucher
        @fetcher = fetcher
      end

      def call root, images_uri:, encryption: nil
        toucher.call root
        fetcher.call root, images_uri:, encryption:
      end

      private

      attr_reader :toucher, :fetcher
    end
  end
end
