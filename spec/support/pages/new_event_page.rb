class NewEventPage
  include Capybara::DSL
  include Formulaic::Dsl

  attr_reader :location, :name, :takes_place_on
  protected :location, :name, :takes_place_on

  def initialize(location:, name:, takes_place_on:)
    @location = location
    @name = name
    @takes_place_on = takes_place_on
  end

  def create
    fill_form(
      :event,
      location: location,
      name: name,
      takes_place_on: takes_place_on,
    )
    click_button "Create Event"
  end

  def visit
    super("/events/new")
  end
end
