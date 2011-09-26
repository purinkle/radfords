class EventsController < ApplicationController
  def new
    @title = 'New Event'
    @event  = Event.new
  end
  
  def index
    @title = 'Listing events'
  end
end
