require 'spec_helper'

describe OrdersController do
  context '#new' do
    it 'is successful' do
      get :new
      response.should be_success
    end

    it 'sets the title' do
      get :new
      assigns(:title).should == 'New order'
    end
  end
end
