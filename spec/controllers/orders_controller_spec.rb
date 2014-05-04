require 'spec_helper'

describe OrdersController do
  describe 'GET "new"' do
    it 'creates a new order' do
      basket = double
      order = double
      session[:basket_id] = 1
      basket.stub(:line_items).once.with(no_args) { [double] }
      Basket.stub(:find).once.with(1) { basket }
      Order.stub(:new).once.with(no_args) { order }

      get :new

      expect(assigns(:order)).to be order
    end

    context 'when there\'s no current basket' do
      it 'redirects to the shop' do
        basket = double
        basket.stub(:id).once.with(no_args) { 1 }
        basket.stub(:line_items).once.with(no_args) { [] }
        Basket.stub(:create).once.with(no_args) { basket }
        Basket.stub(:find).once.with(nil) { raise ActiveRecord::RecordNotFound }

        get :new

        expect(response).to redirect_to shop_url
      end

      it 'sets a notice' do
        basket = double
        basket.stub(:id).once.with(no_args) { 1 }
        basket.stub(:line_items).once.with(no_args) { [] }
        Basket.stub(:create).once.with(no_args) { basket }
        Basket.stub(:find).once.with(nil) { raise ActiveRecord::RecordNotFound }

        get :new

        expect(flash[:notice]).to eql I18n.t('orders.new.notice')
      end
    end

    context 'when there are no items in the basket' do
      it 'redirects to the shop' do
        basket = double
        session[:basket_id] = 1
        basket.stub(:line_items).once.with(no_args) { [] }
        Basket.stub(:find).once.with(1) { basket }

        get :new

        expect(response).to redirect_to shop_url
      end

      it 'sets a notice' do
        basket = double
        session[:basket_id] = 1
        basket.stub(:line_items).once.with(no_args) { [] }
        Basket.stub(:find).once.with(1) { basket }

        get :new

        expect(flash[:notice]).to eql I18n.t('orders.new.notice')
      end
    end
  end

  describe 'POST "create"' do
    let(:order_params) do
      {
        'address' => '1 Test Street',
        'email' => 'alphonso.quigley@example.com',
        'name' => 'Alphonso Quigley',
        'pay_type' => 'Check'
      }
    end

    it 'redirects to the shop' do
      basket = double
      mailer = double
      order = double
      basket.stub(:id).once.with(no_args) { 1 }
      mailer.stub(:deliver).once.with(no_args)
      order.stub(:add_line_items_from_basket).once.with(basket)
      order.stub(:save).once.with(no_args) { true }
      Basket.stub(:create).once.with(no_args) { basket }
      Basket.stub(:destroy).once.with(1)
      Basket.stub(:find).once.with(nil) { raise ActiveRecord::RecordNotFound }
      Mailer.stub(:order_received).once.with(order) { mailer }
      Order.stub(:new).once.with(order_params) { order }
      post :create, order: order_params
      expect(response).to redirect_to shop_url
    end

    context 'when the order can\'t be saved' do
      it 'renders the new order view' do
        basket = double
        order = double
        basket.stub(:id).once.with(no_args) { 1 }
        order.stub(:add_line_items_from_basket).once.with(basket)
        order.stub(:save).once.with(no_args) { false }
        Basket.stub(:create).once.with(no_args) { basket }
        Basket.stub(:find).once.with(nil) { raise ActiveRecord::RecordNotFound }
        Order.stub(:new).once.with(order_params) { order }
        post :create, order: order_params
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET "show"' do
    let(:order) { double(Order) }

    let(:id) { '1' }

    before do
      controller.stub(:authenticate)
      Order.stub(:find).with(id).and_return(order)
    end

    it 'gets the order specified in the params' do
      get :show, id: id
      expect(assigns(:order)).to be(order)
    end
  end
end
