# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Actions::API::Log::Create do
  subject(:action) { described_class.new logger: }

  let(:logger) { instance_spy Dry::Logger::Dispatcher }

  describe "#call" do
    let :headers do
      {
        "SERVER_SOFTWARE" => "Test 0.0.0",
        "SERVER_NAME" => "test.io",
        "SERVER_PORT" => 80,
        "HTTP_BASE64" => "true",
        "HTTP_FW_VERSION" => "0.0.0",
        "HTTP_ACCESS_TOKEN" => "abc123",
        "HTTP_HEIGHT" => 480,
        "HTTP_HOST" => "test.io",
        "HTTP_ID" => "test",
        "HTTP_REFRESH_RATE" => 100,
        "HTTP_USER_AGENT" => "test",
        "HTTP_WIDTH" => 800,
        "REQUEST_METHOD" => "POST",
        "REQUEST_PATH" => "/",
        "REQUEST_URI" => "http://test.io",
        "QUERY_STRING" => "",
        "PATH_INFO" => "/"
      }
    end

    it "logs details" do
      Rack::MockRequest.new(action).get "/api/display", headers
      expect(logger).to have_received(:info).with(headers)
    end

    it "answers success (no content)" do
      response = Rack::MockRequest.new(action).get "/api/display", headers
      expect(response.status).to eq(204)
    end
  end
end
