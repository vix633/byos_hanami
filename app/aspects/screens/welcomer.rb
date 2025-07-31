# frozen_string_literal: true

module Terminus
  module Aspects
    module Screens
      # Creates welcome screen for new device.
      class Welcomer
        include Deps["aspects.screens.creator", view: "views.welcome.new"]

        def call device
          id = device.friendly_id

          creator.call model_id: device.model_id,
                       name: "terminus_welcome_#{id.downcase}",
                       label: "Welcome #{id}",
                       content: String.new(view.call(device:))
        end
      end
    end
  end
end
