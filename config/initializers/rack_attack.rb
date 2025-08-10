# frozen_string_literal: true

require "ipaddr"
require "rack/attack"

# Railway-specific IP ranges
railway_ips = if ENV["RAILWAY_ENVIRONMENT"]
  [
    IPAddr.new("0.0.0.0/0") # Allow all IPs in production for Railway
  ]
else
  []
end

# :nocov:
allowed_subnets = [
  IPAddr.new("10.0.0.0/8"),
  IPAddr.new("172.16.0.0/12"),
  IPAddr.new("192.168.0.0/16"),
  IPAddr.new("127.0.0.1"),
  IPAddr.new("::1"),
  *railway_ips,
  *ENV.fetch("RACK_ATTACK_ALLOWED_SUBNETS", "").split(",").map { IPAddr.new it }
]
# :nocov:

Rack::Attack.safelist "allow subnets" do |request|
  allowed_subnets.any? { |subnet| subnet.include? request.ip }
end

Rack::Attack.throttle("requests by IP", limit: 100, period: 60, &:ip)
