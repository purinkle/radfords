class EventsController < ApplicationController
  def show
    @event = Event.find( params[:id] )
    @title = @event.name
  end

  def new
    @title = 'New Event'
    @event  = Event.new
  end

  def create
    @title = 'New Event'
    @event = Event.new( params[:event] )

    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  def index
    @title = 'Listing events'
  end

  def edit
    @event = Event.find( params[:id] )
    @title = "Edit event"
  end
end
