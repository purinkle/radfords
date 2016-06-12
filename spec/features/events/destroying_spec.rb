require "rails_helper"

describe "destroying events" do
  let(:event) { create(:event) }

  it "destroys existing events" do
    sign_in
    visit delete_event_url(event)

    click_button("Delete Event")

    expect(page).to have_title("Events")
    expect(page).to have_content("You successfully deleted the event.")
    expect(Event.count).to be_zero
  end
end
