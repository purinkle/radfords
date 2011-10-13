require "spec_helper"

describe "FriendlyFowardings" do
  it "should forward to the requested page after signin" do
    user = Factory(:user)

    visit edit_event_path( Factory(:event) )

    fill_in :email, :with => user.email
    fill_in :password, :with => user.password

    click_button

    response.should render_template("events/edit")
  end
end