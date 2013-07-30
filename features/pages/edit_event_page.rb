class EditEventPage
  include Capybara::DSL
  include Capybara::Node::Matchers
  include RSpec::Matchers

  def initialize(name = nil, location = nil, takes_place_on = nil)
    @name = name
    @location = location
    @takes_place_on = takes_place_on
  end

  def update
    fill_in "Name", with: name
    fill_in "Location", with: location
    fill_in "Takes place on", with: takes_place_on

    click_button "Update"
  end

  private

  attr_reader :location, :name, :takes_place_on
end
