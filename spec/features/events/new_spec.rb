require "rails_helper"

module Features
  describe "create event" do
    let(:new_event_page) do
      NewEventPage.new(
        location: location,
        name: name,
        takes_place_on: takes_place_on,
      )
    end

    let(:name) { "Maker's Market" }
    let(:location) { "Sandbach" }
    let(:takes_place_on) { Date.tomorrow.strftime("%e %B %Y") }

    it "successfully creates an event" do
      sign_in
      new_event_page.visit

      new_event_page.create

      expect(page).to have_content(name)
      expect(page).to have_content(takes_place_on)
      expect(page).to have_content(location)
    end

    context "when there is no name" do
      let(:name) { "" }

      it "does not create events" do
        sign_in
        new_event_page.visit

        new_event_page.create

        expect(page).to have_title("New Event")
        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end
