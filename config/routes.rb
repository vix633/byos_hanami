# frozen_string_literal: true

module Terminus
  # The application base routes.
  class Routes < Hanami::Routes
    get "/", to: "dashboard.show"

    get "/devices", to: "devices.index", as: :devices_index
    get "/devices/:id", to: "devices.show", as: :devices_show
    get "/devices/new", to: "devices.new", as: :devices_new
    post "/devices", to: "devices.create", as: :devices_create
    get "/devices/:id/edit", to: "devices.edit", as: :devices_edit
    put "/devices/:id", to: "devices.update", as: :devices_update

    slice(:health, at: "/up") { root to: "show" }

    use Rack::Static, root: "public", urls: ["/.well-known/security.txt"]
  end
end
