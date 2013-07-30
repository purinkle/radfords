class NewEventsPage
  include Capybara::DSL
  include Capybara::Node::Matchers
  include RSpec::Matchers

  def initialize(name = nil, location = nil, takes_place_on = nil)
    @name = name
    @location = location
    @takes_place_on = takes_place_on
  end

  def create
    fill_in "Name", with: name
    fill_in "Location", with: location
    fill_in "Takes place on", with: takes_place_on
    click_button "Create Event"
  end

  private

  attr_reader :name, :location, :takes_place_on
end
