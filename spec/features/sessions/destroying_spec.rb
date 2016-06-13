require "rails_helper"

describe "destroying sessions" do
  it "destroys existing session" do
    sign_in

    click_link "Sign Out"

    expect(page).to have_content("You successfully signed out.")
    expect(page).to_not have_content("Sign Out")
  end
end
