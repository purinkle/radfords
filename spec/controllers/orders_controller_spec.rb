require "rails_helper"

describe OrdersController do
  describe "GET 'new'" do
    let(:basket) { instance_double(Basket, line_items: items) }
    let(:items) { [instance_double(LineItem)] }
    let(:notice) { "Your basket is empty." }
    let(:order) { instance_double(Order) }

    before do
      allow(controller).to receive(:current_basket).and_return basket
      allow(controller).to receive(:t).with("orders.new.notice")
                                      .and_return notice
      allow(Order).to receive(:new).and_return order
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
    let(:basket) { instance_double(Basket, line_items: [instance_double(LineItem)]) }
    let(:id) { 1 }
    let(:order) { instance_double(Order, id: id, save!: nil) }
    let(:params) { { "order" => { "name" => "Alphonso Quigley" }, "stripe_token" => stripe_token } }
    let(:stripe_token) { "test_stripe_token" }

    before do
      allow(controller).to receive(:current_basket).and_return basket
      allow(Order).to receive(:new).and_return(order)
      allow(OrderBuilder).to receive(:build).with(order, stripe_token)
    end

    it "builds the order" do
      post :create, params: params

      expect(OrderBuilder).to have_received(:build).with(order, stripe_token)
    end

    it "deletes the basket ID from the session" do
      post :create, params: params

      expect(session.fetch(:basket_id)).to be_nil
    end

    it "adds the order ID to the session" do
      post :create, params: params

      expect(session.fetch(:order_id)).to be id
    end

    it "sets the flash" do
      post :create, params: params

      expect(flash[:partial]).to eql "thank_you"
    end

    it "redirects the the homepage" do
      post :create, params: params

      expect(response).to redirect_to root_url
    end
  end

  describe "GET 'show'" do
    let(:id) { "1" }
    let(:order) { instance_double(Order) }
    let(:params) { { id: id } }

    before do
      allow(controller).to receive :authenticate
      allow(order).to receive(:update).with(viewed: true)
      allow(Order).to receive(:with_line_items).and_return(Order)
      allow(Order).to receive(:find).with(id).and_return order
    end

    it "marks the order as 'viewed'" do
      get :show, params: params

      expect(order).to have_received(:update).with(viewed: true)
    end
  end
end
