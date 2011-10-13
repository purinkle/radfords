require 'spec_helper'

describe EventsController do
  render_views

  describe 'GET "show"' do
    before (:each) do
      @event = Factory(:event)

      test_sign_in( Factory(:user) )
    end

    it 'should be successful' do
      get :show, :id => @event

      response.should be_success
    end

    it 'should find the right event' do
      get :show, :id => @event

      assigns(:event).should == @event
    end

    it 'should have the right title' do
      get :show, :id => @event

      response.should have_selector( 'title', :content => @event.name )
    end

    it 'should include the event\'s name' do
      get :show, :id => @event

      response.should have_selector( 'h1', :content => @event.name )
    end

    it 'should include the event\'s date' do
      get :show, :id => @event

      response.should have_selector( 'h2', :content => @event.takes_place_on )
    end

    it 'should include the event\'s location' do
      get :show, :id => @event

      response.should have_selector( 'h2', :content => @event.location )
    end
  end

  describe 'GET "new"' do
    before (:each) do
      test_sign_in( Factory(:user) )
    end

    it 'should be successful' do
      get 'new'

      response.should be_success
    end

    it 'should have the right title' do
      get 'new'

      response.should have_selector('title', :content => 'New Event')
    end

    it 'should have a name field' do
      get :new

      response.should have_selector("input[name='event[name]'][type='text']")
    end

    it 'should have a takes_place_on field' do
      get :new

      response.should have_selector("input[name='event[takes_place_on]'][type='text']")
    end

    it 'should have a location field' do
      get :new

      response.should have_selector('input[name="event[location]"][type="text"]')
    end
  end

  describe 'POST "create"' do
    describe 'failure' do
      before (:each) do
        test_sign_in( Factory(:user) )

        @attr = {
          :name           => '',
          :takes_place_on => '',
          :location       => ''
        }
      end

      it 'should not create an event' do
        lambda do
          post :create, :event => @attr
        end.should_not change( Event, :count )
      end

      it 'should have the right title' do
        post :create, :event => @attr

        response.should have_selector( 'title', :content => 'New Event' )
      end

      it 'should render the new page' do
        post :create, :event => @attr

        response.should render_template('new')
      end
    end

    describe 'success' do
      before (:each) do
        test_sign_in( Factory(:user) )

        @attr = {
          :name           => 'Macclesfield Farmers Market',
          :takes_place_on => '2 October 2011',
          :location       => 'Town Hall, Macclesfield'
        }
      end

      it 'should create an event' do
        lambda do
          post :create, :event => @attr
        end.should change( Event, :count ).by(1)
      end

      it 'should redirect to the user show page' do |variable|
        post :create, :event => @attr

        response.should redirect_to( event_path( assigns(:event) ) )
      end
    end
  end

  describe 'GET "index"' do
    before (:each) do
      @event = Factory(:event)

      test_sign_in( Factory(:user) )
    end

    it 'should be successful' do
      get 'index'

      response.should be_success
    end

    it 'should have the right title' do
      get 'index'

      response.should have_selector( 'title', :content => 'Listing events' )
    end
  end

  describe "GET 'edit'" do
    before (:each) do
      @event = Factory(:event)

      test_sign_in( Factory(:user) )
    end

    it "should be successful" do
      get :edit, :id => @event

      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @event

      response.should have_selector( :title, :content => "Edit event" )
    end
  end

  describe "authentication of all pages" do
    before (:each) do
      @event = Factory(:event)

      @attr = {
        :name           => 'Macclesfield Farmers Market',
        :takes_place_on => '2 October 2011',
        :location       => 'Town Hall, Macclesfield'
      }
    end

    describe "for non-signed-in users" do
      it "should deny access to 'index'" do
        get :index

        response.should redirect_to(signin_path)
      end

      it "should deny access to 'create'" do
        post :create, :event => @attr

        response.should redirect_to(signin_path)
      end

      it "should deny access to 'new'" do
        get :new

        response.should redirect_to(signin_path)
      end

      it "should deny access to 'edit'" do
        get :edit, :id => @event

        response.should redirect_to(signin_path)
      end

      it "should deny access to 'show'" do
        get :show, :id => @event

        response.should redirect_to(signin_path)
      end
    end
  end
end
