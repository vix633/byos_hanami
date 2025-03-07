# frozen_string_literal: true

module Terminus
  module Views
    module Devices
      # The edit view.
      class Edit < Terminus::View
        expose :device
        expose :errors
      end
    end
  end
end
