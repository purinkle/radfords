require 'spec_helper'

describe OrdersController do
  context '#new' do
    let(:order) { stub }

    before(:each) do
      Order.stub(new: order)
    end

    it 'is successful' do
      get :new
      response.should be_success
    end

    it 'sets the title' do
      get :new
      assigns(:title).should == 'New order'
    end

    it 'creates a new order' do
      Order.should_receive(:new).with(no_args)
      get :new
    end

    it 'stores the order' do
      get :new
      assigns(:order).should == order
    end
  end
end
