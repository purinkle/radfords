require_relative "event_form"

class NewEventsPage < EventForm
  def create
    complete("Create Event", attributes)
  end
end
