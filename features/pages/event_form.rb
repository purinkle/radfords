class EventForm
  include Capybara::DSL

  def initialize(attributes = {})
    @attributes = attributes
  end

  def complete(action, attributes)
    fill_in "Name", with: attributes[:name]
    fill_in "Location", with: attributes[:location]
    fill_in "Takes place on", with: attributes[:takes_place_on]

    click_button action
  end

  private

  attr_reader :attributes
end
