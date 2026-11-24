class EventsController < ApplicationController
  before_action :find_event, only: %i[show edit update destroy delete]
  rescue_from ActiveRecord::RecordNotFound, with: :event_not_found

  def index
    @events = Event.all
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params)
    create_and_show(@event)
  end

  def update
    update_and_show(@event, event_params)
  end

  def destroy
    @event.destroy
    redirect_to(events_path, notice: t(".notice"))
  end

  def delete; end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def event_not_found
    redirect_to(events_path, alert: t("events.not_found"))
  end

  def event_params
    params.require(:event).permit(:location, :name, :takes_place_on)
  end
end
