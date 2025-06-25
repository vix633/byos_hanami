# frozen_string_literal: true

Factory.define :model, relation: :model do |factory|
  factory.sequence(:label) { "T#{it}" }
  factory.sequence(:name) { "t#{it}" }
  factory.width 800
  factory.height 480
  factory.published_at { Time.now }
end
