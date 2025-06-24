# frozen_string_literal: true

require "hanami_helper"

RSpec.describe "/api/models", :db do
  it "answers models" do
    model = Factory[:model]
    get routes.path(:api_models), "CONTENT_TYPE" => "application/json"

    expect(json_payload).to match(
      data: [
        hash_including(
          id: 1,
          label: "T1",
          name: "t1",
          description: nil,
          width: 800,
          height: 480,
          published_at: model.published_at.to_s
        )
      ]
    )
  end
end
