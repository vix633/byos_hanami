# frozen_string_literal: true

require "base64"
require "refinements/pathname"

module Terminus
  module Images
    # Fetches image for rendering on device screen.
    class Fetcher
      using Refinements::Pathname

      ENCRYPTIONS = %i[base_64].freeze

      def initialize encryptions: ENCRYPTIONS
        @encryptions = encryptions
      end

      def call root_path = Pathname.pwd, images_uri:, encryption: nil
        last_generated_image(root_path, images_uri, encryption) || default_image(images_uri)
      end

      private

      attr_reader :encryptions

      # :reek:FeatureEnvy
      def last_generated_image root_path, images_uri, encryption
        image_path = root_path.files("*.bmp").max_by(&:ctime)

        return unless image_path

        filename = image_path.basename.to_s

        if encryptions.include?(encryption) && encryption == :base_64
          {filename:, image_url: "data:image/bmp;base64,#{Base64.strict_encode64 image_path.read}"}
        else
          {filename:, image_url: "#{images_uri}/generated/#{filename}"}
        end
      end

      def default_image images_uri
        {filename: "empty_state", image_url: "#{images_uri}/setup/logo.bmp"}
      end
    end
  end
end
