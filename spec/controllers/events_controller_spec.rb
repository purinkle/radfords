require 'spec_helper'

describe EventsController do
  render_views

  describe 'GET "show"' do
    before (:each) do
      @event = FactoryGirl.create(:event)

      test_sign_in( FactoryGirl.create(:user) )
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

      response.should have_selector( 'dd', :content => @event.name )
    end

    it 'should include the event\'s date' do
      get :show, :id => @event

      response.should have_selector( 'dd', :content => @event.takes_place_on )
    end

    it 'should include the event\'s location' do
      get :show, :id => @event

      response.should have_selector( 'dd', :content => @event.location )
    end
  end

  describe 'GET "new"' do
    before (:each) do
      test_sign_in( FactoryGirl.create(:user) )
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
        test_sign_in( FactoryGirl.create(:user) )

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
        test_sign_in( FactoryGirl.create(:user) )

        @attr = {
          :name           => 'Macclesfield Farmers Market',
          :takes_place_on => 1.week.from_now,
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
      test_sign_in( FactoryGirl.create(:user) )

      @event = FactoryGirl.create(:event, takes_place_on: 1.hour.from_now )

      second = FactoryGirl.create( :event, :name => "This Event",
                                takes_place_on: 1.hour.from_now,
                                :location => "London, UK" )

      third = FactoryGirl.create( :event, :name => "That Event",
                               takes_place_on: 1.hour.from_now,
                               :location => "New York, NY" )

      @events = [ @event, second, third ]

      30.times do
        @events << FactoryGirl.create(:event)
      end
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
      @event = FactoryGirl.create(:event)

      test_sign_in( FactoryGirl.create(:user) )
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
      @event = FactoryGirl.create(:event)

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

      it "should deny access to 'update'" do
        put :update, :id => @event, :event => @attr

        response.should redirect_to(signin_path)
      end
    end
  end

  describe "PUT 'update'" do
    before (:each) do
      @event = FactoryGirl.create(:event)

      test_sign_in( FactoryGirl.create(:user) )
    end

    describe "failure" do
      before (:each) do
        @attr = { :name => "", :takes_place_on => "", :location => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @event, :event => @attr

        response.should render_template("edit")
      end

      it "should have the right title" do
        put :update, :id => @event, :event => @attr

        response.should have_selector( :title, :content => "Edit event" )
      end
    end

    describe "success" do
      before (:each) do
        @attr = { :name => "New Name", :takes_place_on => "13 October 2011",
                  :location => "New Location" }
      end

      it "should change the event's attributes" do
        put :update, :id => @event, :event => @attr

        @event.reload

        @event.name.should == @attr[:name]
        @event.takes_place_on.should == @attr[:takes_place_on]
        @event.location.should == @attr[:location]
      end

      it "should redirect to the user show page" do
        put :update, :id => @event, :event => @attr

        response.should redirect_to( event_path(@event) )
      end

      it "should have a flash message" do
        put :update, :id => @event, :event => @attr

        flash[:success].should =~ /updated/
      end
    end
  end
end
