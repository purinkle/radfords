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
    let(:address) do
      [
        address_line_1,
        address_line_2,
        address_city,
        address_post_code,
        address_county
      ].join("\n")
    end

    let(:params) do
      {
        order: {
          address_line_1: address_line_1,
          address_line_2: address_line_2,
          address_city: address_city,
          address_post_code: address_post_code,
          address_county: address_county,
          email: email,
          name: name
        },
        stripe_token: stripe_token
      }
    end

    let(:address_line_1) { '1 Test Road' }
    let(:address_line_2) { 'Testerton' }
    let(:address_city) { 'Testington' }
    let(:address_post_code) { 'TE5 7TE' }
    let(:address_county) { 'Testshire' }
    let(:basket_id) { 2 }
    let(:cents) { 395 }
    let(:current_basket) { double(Basket) }
    let(:email) { 'alphonso.quigley@example.com' }
    let(:id) { 1 }
    let(:mailer) { double(Mail::Message, deliver: nil) }
    let(:name) { 'Alphonso Quigley' }
    let(:order) { double(Order, id: id, save: save, total_price: total_price) }
    let(:order_params) { { address: address, email: email, name: name } }
    let(:save) { true }
    let(:stripe_token) { 'tok_103lhG2vVN1WVbyyA7ZfQcLz' }
    let(:total_price) { Money.new(cents) }

    before do
      controller.stub(current_basket: current_basket)
      order.stub(:add_line_items_from_basket).with(current_basket)
      session[:basket_id] = basket_id
      Basket.stub(:destroy).with(basket_id)
      ChargesCustomers.stub(:charge).with(email, stripe_token, cents, id)
      Mailer.stub(:order_received).with(order).and_return(mailer)
      Order.stub(:new).with(order_params).and_return(order)
    end

    it 'redirects to the homepage' do
      post :create, params
      expect(response).to redirect_to(root_url)
    end

    context 'when the order cannot be saved' do
      let(:save) { false }

      it 'renders the new order view' do
        post :create, params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET "show"' do
    let(:order) { double(Order) }

    let(:id) { '1' }

    before do
      controller.stub(:authenticate)
      order.stub(:update_attribute).with(:viewed, true).and_return(order)
      Order.stub(:find).with(id).and_return(order)
    end

    it 'gets the order specified in the params' do
      get :show, id: id
      expect(assigns(:order)).to be(order)
    end

    it 'marks the order as viewed' do
      get :show, id: id
      expect(order).to have_received(:update_attribute).with(:viewed, true)
    end
  end

  describe 'GET "index"' do
    let(:orders) { [double(Order)] }

    before do
      controller.stub(:authenticate)
      Order.stub(by_created_at: orders)
    end

    it 'gets all of the orders' do
      get :index
      expect(assigns(:orders)).to be(orders)
    end
  end
end
