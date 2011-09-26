require 'spec_helper'

describe EventsController do
  render_views
  
  describe 'GET "new"' do
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
  end
  
  describe 'GET "index"' do
    it 'should be successful' do
      get 'index'
      
      response.should be_success
    end
    
    it 'should have the right title' do
      get 'index'
      
      response.should have_selector( 'title', :content => 'Listing events' )
    end
  end
end
