# frozen_string_literal: true

require "dry/monads"
require "ferrum"
require "refinements/pathname"

module Terminus
  module Aspects
    module Screens
      # Saves web page as screenshot.
      class Shoter
        include Dry::Monads[:result]

        using Refinements::Pathname

        SETTINGS = {
          browser_options: {
            "disable-dev-shm-usage" => nil,
            "disable-gpu" => nil,
            "hide-scrollbar" => nil,
            "no-sandbox" => nil
          },
          js_errors: true
        }.freeze

        VIEWPORT = {width: 800, height: 480, scale_factor: 1}.freeze

        def initialize settings: SETTINGS, browser: Ferrum::Browser
          @settings = settings
          @browser = browser
        end

        def call content, output_path, viewport: VIEWPORT
          save content, viewport, output_path
          Success output_path
        end

        private

        attr_reader :settings, :browser

        def save content, viewport, output_path
          Pathname.mktmpdir do |work_dir|
            instance = browser.new settings

            instance.create_page
            instance.set_viewport(**viewport)
            instance.main_frame.content = work_dir.join("content.html").write(content).read
            instance.network.wait_for_idle duration: 1
            instance.screenshot path: output_path.to_s
            instance.quit
          end
        end
      end
    end
  end
end
