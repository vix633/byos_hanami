# frozen_string_literal: true

module Terminus
  # The application base routes.
  class Routes < Hanami::Routes
    get "/", to: "dashboard.show"

    get "/devices", to: "devices.index", as: :devices_index

    slice(:health, at: "/up") { root to: "show" }

    use Rack::Static, root: "public", urls: ["/.well-known/security.txt"]
  end
end
