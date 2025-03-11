# frozen_string_literal: true

module Terminus
  # The application base settings.
  class Settings < Hanami::Settings
    setting :app_host, constructor: Types::Params::String
    setting :app_url, constructor: Types::Params::String
    setting :images_root, constructor: Types::Params::String
  end
end
