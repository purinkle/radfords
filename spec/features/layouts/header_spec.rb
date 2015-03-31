require "spec_helper"

describe "application header" do
  let(:home_page) { HomePage.new }
  let(:signin_page) { SigninPage.new(user.email, user.password) }
  let(:user) { FactoryGirl.create(:user) }

  before { sign_in }

  it "navigates to 'Your Basket'" do
    home_page.visit
    home_page.go_to_basket

    expect(page).to have_title "Your Basket"
  end

  def sign_in
    signin_page.visit
    signin_page.sign_in
  end
end
