# frozen_string_literal: true

Hanami.app.register_provider :trmnl_api do
  prepare { require "trmnl/api" }

  start { register :trmnl_api, TRMNL::API::Client.new }
end
