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

    let(:email) { user.email }
    let(:name) { "Maker's Market" }
    let(:location) { "Sandbach" }
    let(:password) { user.password }
    let(:signin_page) { SigninPage.new(email, password) }
    let(:takes_place_on) { Date.tomorrow.strftime("%e %B %Y") }
    let(:user) { FactoryGirl.create(:user) }

    it "successfully creates an event" do
      visit signin_path
      signin_page.sign_in
      new_event_page.visit

      new_event_page.create

      expect(page).to have_content(name)
      expect(page).to have_content(takes_place_on)
      expect(page).to have_content(location)
    end
  end
end
