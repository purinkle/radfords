### GIVEN ###

Given(/^there is 1 event$/) do
  FactoryGirl.create(:event)

  expect(Event.all.size).to eql 1
end

### WHEN ###

When(/^I create an invalid event$/) do
  new_event_page = NewEventsPage.new

  visit new_event_path

  new_event_page.create
end

When(/^I create a valid event$/) do
  new_event_page = NewEventsPage.new(
    "Macclesfield Farmers Market",
    "Town Hall, Macclesfield",
    "25/08/2013"
  )

  visit new_event_path

  new_event_page.create
end

When(/^I delete an event that doesn't exist$/) do
  visit delete_event_path("1")
end

When(/^I delete the event$/) do
  event = Event.first
  delete_event_page = DeleteEventPage.new

  visit delete_event_path(event)

  delete_event_page.delete_event
end

When(/^I try to edit the event$/) do
  events_page = EventsPage.new

  visit events_path

  events_page.edit_event
end

When(/^I try to view the event$/) do
  events_page = EventsPage.new

  visit events_path

  events_page.view_event
end

When(/^I try to create an event$/) do
  events_page = EventsPage.new

  visit events_path

  events_page.create_event
end

When(/^I update the event with invalid data$/) do
  event = Event.first
  edit_event_page = EditEventPage.new

  visit edit_event_path(event)

  edit_event_page.update
end

When(/^I update the event with valid data$/) do
  event = Event.first
  edit_event_page = EditEventPage.new(
    "Macclesfield Farmers Market",
    "Town Hall, Macclesfield",
    "25/08/2013"
  )

  visit edit_event_path(event)

  edit_event_page.update
end


### THEN ###

Then(/^I see (\d+) events$/) do |count|
  expect(page).to have_selector("tbody tr", count: count.to_i)
end

Then(/^I see the event's page$/) do
  expect(title).to eql "Macclesfield Farmers Market | Radfords of Somerford"
end

Then(/^I see the name of the event$/) do
  expect(page).to have_content("Macclesfield Farmers Market")
end

Then(/^I see the location of the event$/) do
  expect(page).to have_content("Town Hall, Macclesfield")
end

Then(/^I see the date the event takes place on$/) do
  expect(page).to have_content("25 August 2013")
end

Then(/^the date the event takes place on is pre\-populated$/) do
  field = find_field("Takes place on")
  expect(field.value).to eql "2013-08-25"
end

Then(/^the location of the event is pre\-populated$/) do
  field = find_field("Location")
  expect(field.value).to eql "Town Hall, Macclesfield"
end

Then(/^the name of the event is pre\-populated$/) do
  field = find_field("Name")
  expect(field.value).to eql "Macclesfield Farmers Market"
end
