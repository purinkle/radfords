require "rails_helper"

describe OrdersController do
  describe "GET 'new'" do
    let(:basket) { double("Basket", line_items: items) }
    let(:items) { [double("LineItem")] }
    let(:notice) { "Your basket is empty." }
    let(:order) { double "Order" }

    before do
      allow(controller).to receive(:current_basket).and_return basket
      allow(controller).to receive(:t).with("orders.new.notice").
        and_return notice
      allow(Order).to receive(:new).and_return order
    end

    it "creates a new order" do
      get :new
      expect(assigns :order).to be order
    end

    it "renders the new page" do
      get :new
      expect(response).to render_template :new
    end

    context "when the basket is empty" do
      let(:items) { [] }

      it "sets the flash" do
        get :new
        expect(flash[:notice]).to be notice
      end

      it "redirects to the shop page" do
        get :new
        expect(response).to redirect_to shop_url
      end
    end
  end

  describe "POST 'create'" do
    let(:basket) { double("Basket", line_items: [double("LineItem")]) }
    let(:exception) { ActiveRecord::RecordInvalid.new(invalid_order) }
    let(:id) { 1 }
    let(:invalid_options) { invalid_params.merge("basket" => basket) }
    let(:invalid_order) { Order.new }
    let(:invalid_params) { { "name" => "" } }
    let(:order) { double("Order", id: id, save!: nil) }
    let(:order_options) { order_params.merge("basket" => basket) }
    let(:order_params) { { "name" => "Alphonso Quigley" } }
    let(:params) { { "order" => order_params, "stripe_token" => stripe_token } }
    let(:stripe_token) { "test_stripe_token" }

    before do
      allow(controller).to receive(:current_basket).and_return basket
      allow(invalid_order).to receive(:save!).and_raise exception
      allow(Order).to receive(:new).with(order_options).and_return order
      allow(Order).to receive(:new).with(invalid_options).
        and_return invalid_order
      allow(OrderBuilder).to receive(:build).with(order, stripe_token)
    end

    it "creates a new order" do
      post :create, params
      expect(assigns :order).to be order
    end

    it "builds the order" do
      post :create, params
      expect(OrderBuilder).to have_received(:build).with(order, stripe_token)
    end

    it "deletes the basket ID from the session" do
      post :create, params
      expect(session.fetch :basket_id).to be_nil
    end

    it "adds the order ID to the session" do
      post :create, params
      expect(session.fetch :order_id).to be id
    end

    it "sets the flash" do
      post :create, params
      expect(flash[:partial]).to eql "thank_you"
    end

    it "redirects the the homepage" do
      post :create, params
      expect(response).to redirect_to root_url
    end

    context "when the order is invalid" do
      let(:order_params) { invalid_params }

      it "renders the new page" do
        post :create, params
        expect(response).to render_template :new
      end
    end
  end

  describe "GET 'show'" do
    let(:id) { "1" }
    let(:order) { double "Order" }
    let(:params) { { id: id } }

    before do
      allow(controller).to receive :authenticate
      allow(order).to receive(:update_attribute).with(:viewed, true)
      allow(Order).to receive(:find).with(id).and_return order
    end

    it "gets the order" do
      get :show, params
      expect(assigns :order).to be order
    end

    it "marks the order as 'viewed'" do
      get :show, params
      expect(order).to have_received(:update_attribute).with(:viewed, true)
    end
  end

  describe "GET 'index'" do
    let(:orders) { [] }

    before do
      allow(controller).to receive :authenticate
      allow(Order).to receive(:by_created_at).and_return orders
    end

    it "gets the orders" do
      get :index
      expect(assigns :orders).to be orders
    end
  end
end
