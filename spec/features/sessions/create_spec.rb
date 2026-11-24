require "rails_helper"

describe "creating sessions" do
  it "signs the user in through the browser", :js do
    sign_in

    expect(page).to have_title("Events")
    expect(page).to have_link("Sign Out")
  end

  context "when there is no email" do
    it "does not create a session" do
      visit signin_url

      fill_form_and_submit(:session, :new, {})

      expect(page).to have_title("Sign in")
      expect(page).to have_text("Invalid email or password.")
    end
  end
end
