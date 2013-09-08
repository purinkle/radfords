require_relative 'event_form'

class EditEventPage < EventForm
  def update
    complete("Update", attributes)
  end
end
