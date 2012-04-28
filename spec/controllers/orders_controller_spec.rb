require 'spec_helper'

describe OrdersController do
  context '#new' do
    let(:basket) { stub(line_items: stub(empty?: false)) }
    let(:basket_id) { stub }
    let(:order) { stub }

    before(:each) do
      Basket.stub(find: basket)
      Order.stub(new: order)
    end

    it 'tries to find the current basket' do
      Basket.should_receive(:find).with(basket_id)
      session[:basket_id] = basket_id
      get :new
    end

    context 'when a basket cannot be found' do
      before(:each) do
        basket.stub(id: basket_id)
        Basket.stub(:find).and_raise(ActiveRecord::RecordNotFound)
        Basket.stub(create: basket)
      end

      it 'creates a basket' do
        Basket.should_receive(:create).with(no_args)
        get :new
      end

      it 'gets the basket identifier' do
        basket.should_receive(:id).with(no_args)
        get :new
      end

      it 'stores the basker identifier' do
        get :new
        session[:basket_id].should == basket_id
      end
    end

    it 'checks if the basket is empty' do
      basket.line_items.should_receive(:empty?).with(no_args)
      get :new
    end

    context 'when the basket is empty' do
      before(:each) do
        basket.line_items.stub(empty?: true)
      end

      it 'sets the notice flash' do
        get :new
        flash[:notice].should == 'Your cart is empty.'
      end

      it 'redirects to the products page' do
        get :new
        response.should redirect_to(products_path)
      end
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

    it 'is successful' do
      get :new
      response.should be_success
    end
  end
end
