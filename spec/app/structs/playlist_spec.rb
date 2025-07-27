# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Structs::Playlist, :db do
  subject(:playlist) { Factory[:playlist] }

  describe "#current_item_position" do
    let(:update) { Terminus::Repositories::Playlist.new.find playlist.id }

    it "answers default when current item is missing" do
      expect(update.current_item_position).to eq(1)
    end

    it "answers position when current item is available" do
      Factory[:playlist, current_item_id: Factory[:playlist_item, position: 5].id]
      expect(update.current_item_position).to eq(1)
    end
  end
end
