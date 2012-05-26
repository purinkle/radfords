require 'spec_helper'

describe OrdersController do
  context "#index" do
    let(:orders) { stub }

    before(:each) do
      Order.stub(all: orders)
    end

    it "gets all the orders" do
      Order.should_receive(:all).with(no_args)
      get :index
    end

    it "stores the orders" do
      get :index
      assigns(:orders).should == orders
    end

    it "is successful" do
      get :index
      response.should be_success
    end
  end

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

  context 'POST "create"' do
    let(:basket) { stub }
    let(:basket_id) { stub }
    let(:order) { stub(add_line_items_from_basket: nil, save: true) }

    before(:each) do
      Basket.stub(find: basket, destroy: nil)
      Order.stub(new: order)
      session[:basket_id] = basket_id
    end

    it 'tries to find the current basket' do
      Basket.should_receive(:find).with(basket_id)
      post :create, order: order
    end

    context 'when a basket cannot be found' do
      before(:each) do
        basket.stub(id: basket_id)
        Basket.stub(:find).and_raise(ActiveRecord::RecordNotFound)
        Basket.stub(create: basket)
        order.stub(save: false)
      end

      it 'creates a basket' do
        Basket.should_receive(:create).with(no_args)
        post :create, order: order
      end

      it 'gets the basket identifier' do
        basket.should_receive(:id).with(no_args)
        post :create, order: order
      end

      it 'stores the basker identifier' do
        post :create, order: order
        session[:basket_id].should == basket_id
      end
    end

    it 'creates a new order' do
      Order.should_receive(:new).with(order)
      post :create, order: order
    end

    it 'stores the order' do
      post :create, order: order
      assigns(:order).should == order
    end

    it 'adds items from the basket to the order' do
      order.should_receive(:add_line_items_from_basket).with(basket)
      post :create, order: order
    end

    it 'tries to save the order' do
      order.should_receive(:save).with(no_args)
      post :create, order: order
    end

    context 'when the order is saved successfully' do
      it 'deletes the basket' do
        Basket.should_receive(:destroy).with(basket_id)
        post :create, order: order
      end

      it 'deletes the basket identifier from the session' do
        post :create, order: order
        session[:basket_id].should be_nil
      end

      it 'sets the success flash' do
        post :create, order: order
        flash[:success].should == 'Thank you for your order.'
      end

      it 'redirects to the products page' do
        post :create, order: order
        response.should redirect_to(products_path)
      end
    end

    context 'when the order is not saved successfully' do
      before(:each) do
        order.stub(save: false)
      end

      it 'renders the new order page' do
        post :create, order: order
        response.should render_template('new')
      end
    end
  end
end
