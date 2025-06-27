# auto_register: false
# frozen_string_literal: true

module Terminus
  module Aspects
    module Models
      # Formats records as options for use within a HTML select element.
      Optioner = lambda do |prompt = "Select...", repository: Hanami.app["repositories.model"]|
        records = repository.all
        initial = prompt && records.any? ? [[prompt, nil]] : []

        records.reduce(initial) { |all, record| all.append [record.label, record.id] }
      end
    end
  end
end
