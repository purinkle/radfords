require "rails_helper"

describe EventsController do
  let(:event_params) do
    {
      'location' => 'Market Square',
      'name' => 'Farmers\' Market',
      'takes_place_on' => '01/01/1970'
    }
  end

  describe "GET 'show'" do
    it "finds the event" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:find).and_return(event)

      get :show, id: "1"

      expect(assigns(:event)).to be event
    end
  end

  describe "GET 'new'" do
    it "creates a new event" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:new).and_return(event)

      get :new

      expect(assigns(:event)).to be event
    end
  end

  describe 'POST "create"' do
    it "finds the event" do
      event = Event.new
      allow(event).to receive(:save!).and_return(true)
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:new).and_return(event)

      post :create, event: event_params

      expect(assigns(:event)).to be event
    end

    it "saves the event" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(event).to receive(:save!)
      allow(Event).to receive(:new).and_return(event)

      post :create, event: event_params
      expect(event).to have_received(:save!)
    end

    it "redirects to the event's page" do
      event = Event.new
      allow(event).to receive(:save!).and_return(true)
      allow(event).to receive(:url_for).and_return("")
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:new).and_return(event)

      post :create, event: event_params

      expect(response).to redirect_to event
    end

    it "sets the notice flash" do
      event = Event.new
      allow(event).to receive(:save!).and_return(true)
      allow(event).to receive(:url_for).and_return("")
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:new).and_return(event)

      post :create, event: event_params

      expect(flash[:notice]).to eql "You successfully created an event."
    end

    context "when the event is not valid" do
      it "renders the new event page" do
        event = Event.new
        allow(event).to receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(event))
        allow(controller).to receive(:authenticate)
        allow(Event).to receive(:new).and_return(event)

        post :create, event: event_params

        expect(response).to render_template "new"
      end
    end
  end

  describe "GET 'index'" do
    it "finds all of the events" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:all).and_return([event])

      get :index

      expect(assigns(:events)).to eql [event]
    end
  end

  describe "GET 'edit'" do
    it "finds the event" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:find).and_return(event)

      get :edit, id: "1"

      expect(assigns(:event)).to be event
    end
  end

  describe "PUT 'update'" do
    it "finds the event" do
      event = Event.new
      allow(event).to receive(:update_attributes!).and_return(true)
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:find).and_return(event)

      put :update, id: "1", event: event_params

      expect(assigns(:event)).to be event
    end

    it "updates the event" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(event).to receive(:update_attributes!)
      allow(Event).to receive(:find).and_return(event)

      put :update, id: "1", event: event_params
      expect(event).to have_received(:update_attributes!)
    end

    it "redirects to the event's page" do
      event = Event.new
      allow(event).to receive(:update_attributes!).and_return(true)
      allow(event).to receive(:url_for).and_return("")
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:find).and_return(event)

      put :update, id: "1", event: event_params

      expect(response).to redirect_to event
    end

    it "sets the notice flash" do
      event = Event.new
      allow(event).to receive(:update_attributes!).and_return(true)
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:find).and_return(event)

      put :update, id: "1", event: event_params

      expect(flash[:notice]).to eql "You successfully updated the event."
    end

    context "when the event is not valid" do
      it "renders the edit event page" do
        event = Event.new
        exception = ActiveRecord::RecordInvalid.new(event)
        allow(event).to receive(:update_attributes!).and_raise(exception)
        allow(controller).to receive(:authenticate)
        allow(Event).to receive(:find).and_return(event)

        put :update, id: "1", event: event_params

        expect(response).to render_template "edit"
      end
    end
  end

  describe "authentication of all pages" do
    before (:each) do
      @event = FactoryGirl.create(:event)

      @attr = {
        :name           => 'Macclesfield Farmers Market',
        :takes_place_on => '2 October 2011',
        :location       => 'Town Hall, Macclesfield'
      }
    end
  end

  describe "GET 'delete'" do
    it "finds the event" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:find).and_return(event)

      get :delete, id: "1"

      expect(assigns(:event)).to be event
    end

    context "when an event can't be found" do
      it "sets the alert flash" do
        allow(controller).to receive(:authenticate)
        allow(Event).to receive(:find).and_raise(ActiveRecord::RecordNotFound)

        get :delete, id: "1"

        alert = "We couldn't find the event you were looking for."
        expect(flash[:alert]).to eql alert
      end

      it "redirects to the events page" do
        allow(controller).to receive(:authenticate)
        allow(Event).to receive(:find).and_raise(ActiveRecord::RecordNotFound)

        get :delete, id: "1"

        expect(response).to redirect_to events_path
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "destroys the event" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(event).to receive(:destroy)
      allow(Event).to receive(:find).and_return(event)

      delete :destroy, id: "1"
      expect(event).to have_received(:destroy)
    end

    it "redirects to the events index" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:find).and_return(event)

      delete :destroy, id: "1"

      expect(response).to redirect_to events_path
    end

    it "sets the notice flash" do
      event = Event.new
      allow(controller).to receive(:authenticate)
      allow(Event).to receive(:find).and_return(event)

      delete :destroy, id: "1"

      expect(flash[:notice]).to eql "You successfully deleted the event."
    end
  end

  describe "#deny_access" do
    it "stores the return location" do
      get :new

      expect(session[:return_to]).to eql "/events/new"
    end

    it "redirects to the sign in page" do
      get :new

      expect(response).to redirect_to signin_path
    end

    it "sets the alert flash" do
      get :new

      alert = "You need to sign in or sign up before continuing."
      expect(flash[:alert]).to eql alert
    end
  end
end
