# frozen_string_literal: true

repository = Hanami.app["repositories.model"]

repository.find_or_create :name,
                          "t1",
                          label: "T1",
                          description: "The first production model.",
                          width: 800,
                          height: 480,
                          published_at: Time.utc(2024, 6, 25, 0, 0, 0)
