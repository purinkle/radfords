require 'spec_helper'

describe ProductsController do
  describe 'GET "index"' do
    it 'should be successful' do
      get :index

      response.should be_success
    end

    it 'sets the title to "Products"' do
      get :index

      assigns(:title).should == 'Products'
    end
  end

  describe 'GET "new"' do
    it 'should be successful' do
      get :new

      response.should be_success
    end

    it 'sets the title to "New product"' do
      get :new

      assigns(:title).should == 'New product'
    end
  end
end
