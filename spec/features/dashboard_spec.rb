# frozen_string_literal: true

require "hanami_helper"

RSpec.describe "Dashboard", :web do
  it "renders dashboard" do
    visit "/"
    expect(page).to have_content("Dashboard")
  end
end
