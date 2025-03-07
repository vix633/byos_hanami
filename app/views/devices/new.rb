# frozen_string_literal: true

module Terminus
  module Views
    module Devices
      # The new view.
      class New < Terminus::View
        expose :device
        expose :errors
      end
    end
  end
end
