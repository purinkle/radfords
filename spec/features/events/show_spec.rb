require "rails_helper"

describe "show event", :aggregate_failures do
  context "when the person is signed in" do
    it "shows the event" do
      event = create(:event)
      sign_in

      visit event_url(event)

      expect(page).to have_title(event.name)
      expect(page).to have_text(event.location)
    end
  end

  context "when the person is not signed in" do
    it "shows the 'Sign in' page" do
      visit event_url(1)

      expect(page).to have_title(t("titles.sessions.new"))
      expect(page).to have_text(t("sessions.unauthenticated"))
    end
  end
end
