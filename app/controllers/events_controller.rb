class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = event
  end

  def new
    @event = Event.new
  end

  def edit
    @event = event
  end

  def create
    @event = Event.new(event_params)
    create_and_show(@event)
  end

  def update
    @event = event
    @event.update!(event_params)
    redirect_to(@event, notice: t(".notice"))
  rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  def destroy
    event.destroy
    redirect_to(events_path, notice: t(".notice"))
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
