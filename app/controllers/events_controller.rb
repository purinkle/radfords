class EventsController < ApplicationController
  def show
    @event = event
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save!
    redirect_to(@event, notice: "You successfully created an event.")
  rescue ActiveRecord::RecordInvalid
    render "new"
  end

  def index
    @events = Event.all
  end

  def edit
    @event = event
  end

  def update
    @event = event
    @event.update!(event_params)
    redirect_to(@event, notice: "You successfully updated the event.")
  rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  def destroy
    event.destroy
    redirect_to(events_path, notice: "You successfully deleted the event.")
  end

  def delete
    @event = event
  end

  private

  def event
    Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to(events_path, alert: t("events.not_found"))
  end

  def event_params
    params.require(:event).permit(:location, :name, :takes_place_on)
  end
end
