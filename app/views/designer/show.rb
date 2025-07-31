# frozen_string_literal: true

module Terminus
  module Views
    module Designer
      # The show view.
      class Show < Terminus::View
        expose :name, default: :terminus_designer
        expose :label, default: "Designer"
      end
    end
  end
end
