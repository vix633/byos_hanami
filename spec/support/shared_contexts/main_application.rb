# frozen_string_literal: true

RSpec.shared_context "with main application" do
  include_context "with temporary directory"

  let(:app) { Hanami.app }
  let(:settings) { app[:settings] }
  let(:routes) { app[:routes] }
  let(:json_payload) { JSON last_response.body, symbolize_names: true }

  before { allow(settings).to receive(:api_uri).and_return("https://localhost") }
end
