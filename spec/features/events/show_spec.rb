require "rails_helper"

describe "show event" do
  context "when the event does not exist" do
    before { sign_in }

    it "shows the 'Events' page" do
      expect(Event.count).to be_zero

      visit event_url(1)

      expect(page).to have_title(I18n.t("titles.events.index"))
      expect(page).to have_content(I18n.t("events.not_found"))
    end
  end
end
