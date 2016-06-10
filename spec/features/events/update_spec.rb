require "rails_helper"

describe "updating events" do
  it "successfully event" do
    event = create(:event)
    takes_place_on = l(Date.current, format: :event)
    event_attributes = attributes_for(:event)
    updated_event = event_attributes.merge(takes_place_on: takes_place_on)

    sign_in
    visit edit_event_url(event)

    fill_form_and_submit(:event, :edit, updated_event)

    expect(page).to have_title(event.name)
    expect(page).to have_content(event.name)
    expect(page).to have_content(event.location)
    expect(page).to have_content(takes_place_on)
  end

  context "when the attributes are invalid" do
    it "unsuccessfully updates" do
      event = create(:event)

      sign_in
      visit edit_event_url(event)

      fill_form_and_submit(:event, :edit, {})

      expect(page).to have_title("Edit Event")
      expect(page).to have_content("Takes place on can't be blank")
    end
  end
end
