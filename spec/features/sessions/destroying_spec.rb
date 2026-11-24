require "rails_helper"

describe "destroying sessions", :aggregate_failures do
  it "destroys existing session" do
    sign_in

    click_link "Sign Out"

    expect(page).to have_text("You successfully signed out.")
    expect(page).to have_no_text("Sign Out")
  end
end
