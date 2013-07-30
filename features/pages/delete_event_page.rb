class DeleteEventPage
  include Capybara::DSL

  def delete_event
    click_button "Delete Event"
  end
end
