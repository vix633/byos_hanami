# frozen_string_literal: true

module Terminus
  module Actions
    module Devices
      # The index action.
      class Index < Terminus::Action
        include Deps[repository: "repositories.device"]

        def handle *, response
          devices = repository.all
          response.render view, devices:
        end
      end
    end
  end
end
