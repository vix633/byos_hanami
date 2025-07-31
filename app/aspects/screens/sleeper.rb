# frozen_string_literal: true

require "dry/monads"

module Terminus
  module Aspects
    module Screens
      # Creates sleep screen for new device.
      class Sleeper
        include Deps[
          "aspects.screens.creator",
          view: "views.sleep.new",
          screen_repository: "repositories.screen"
        ]
        include Dry::Monads[:result]

        def call device
          id = device.friendly_id
          name = "terminus_sleep_#{id.downcase}"

          find(name).then { |screen| screen ? Success(screen) : create(id, name, device) }
        end

        private

        def find(name) = screen_repository.find_by(name:)

        def create id, name, device
          creator.call model_id: device.model_id,
                       name:,
                       label: "Sleep #{id}",
                       content: String.new(view.call(device:))
        end
      end
    end
  end
end
