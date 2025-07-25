# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Repositories::Playlist, :db do
  subject(:repository) { described_class.new }

  let(:playlist) { Factory[:playlist] }

  describe "#all" do
    it "answers all records by created date/time" do
      playlist
      two = Factory[:playlist, name: "two"]

      expect(repository.all).to eq([playlist, two])
    end

    it "answers empty array when records don't exist" do
      expect(repository.all).to eq([])
    end
  end

  describe "#all_by" do
    it "answers record for single attribute" do
      expect(repository.all_by(label: playlist.label)).to contain_exactly(playlist)
    end

    it "answers record for multiple attributes" do
      expect(repository.all_by(label: playlist.label, name: playlist.name)).to contain_exactly(
        playlist
      )
    end

    it "answers empty array for unknown value" do
      expect(repository.all_by(label: "bogus")).to eq([])
    end

    it "answers empty array for nil" do
      expect(repository.all_by(label: nil)).to eq([])
    end
  end

  describe "#find" do
    it "answers record by ID" do
      expect(repository.find(playlist.id)).to have_attributes(playlist.to_h)
    end

    it "answers nil for unknown ID" do
      expect(repository.find(666)).to be(nil)
    end

    it "answers nil for nil ID" do
      expect(repository.find(nil)).to be(nil)
    end
  end

  describe "#find_by" do
    it "answers record when found by single attribute" do
      expect(repository.find_by(name: playlist.name)).to have_attributes(playlist.to_h)
    end

    it "answers record when found by multiple attributes" do
      expect(repository.find_by(name: playlist.name, label: playlist.label)).to have_attributes(
        playlist.to_h
      )
    end

    it "answers nil when not found" do
      expect(repository.find_by(name: "bogus")).to be(nil)
    end

    it "answers nil for nil" do
      expect(repository.find_by(name: nil)).to be(nil)
    end
  end
end
