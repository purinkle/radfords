require "rails_helper"

describe "creating sessions" do
  context "when there is no email" do
    it "does not create a session" do
      visit signin_url

      fill_form_and_submit(:session, :new, {})

      expect(page).to have_title("Sign in")
      expect(page).to have_content("Invalid email or password.")
    end
  end
end
