class EventsPage
  include Capybara::DSL
  include Capybara::Node::Matchers
  include RSpec::Matchers

  def view_event
    click_link "Macclesfield Farmers Market"
  end

  def create_event
    click_link "New"
  end

  def edit_event
    click_link "Edit"
  end
end
