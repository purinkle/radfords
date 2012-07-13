class EventsController < ApplicationController
  before_filter :authenticate, except: :destroy

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
    @events = Event.paginate( page: params[:page] )
  end

  def edit
    @event = Event.find( params[:id] )
    @title = "Edit event"
  end

  def update
    @event = Event.find( params[:id] )

    if @event.update_attributes( params[:event] )
      flash[:success] = "Event updated."

      redirect_to @event
    else
      @title = "Edit event"
      render "edit"
    end
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    redirect_to events_path
  end

  private
    def authenticate
      deny_access unless signed_in?
    end
end
