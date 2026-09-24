require "rails_helper"

describe "creating sessions in a browser", js: true do
  it "signs the user in" do
    sign_in

    expect(page).to have_title("Events")
    expect(page).to have_link("Sign Out")
  end
end
