require "rails_helper"

describe "application header" do
  let(:home_page) { HomePage.new }
  let(:user) { FactoryGirl.create(:user) }

  it "navigates to 'Your Basket'" do
    home_page.visit
    home_page.go_to_basket

    expect(page).to have_title "Your Basket"
  end
end
