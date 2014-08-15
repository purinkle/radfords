require 'spec_helper'

describe PagesController do
  before (:each) do
    @base_title = "Radfords of Somerford"
  end

  describe "GET 'home'" do
    let(:basket) { double("Basket") }
    let(:basket_id) { 2 }
    let(:null_basket) { double("NullBasket") }
    let(:session_basket) { basket_id }

    before do
      allow(Basket).to receive(:find).with(basket_id).and_return(basket)
      allow(Basket).to receive(:find).with(nil).and_raise(ActiveRecord::RecordNotFound)
      allow(NullBasket).to receive(:new).and_return(null_basket)
      session[:basket_id] = session_basket
    end

    it "should be successful" do
      get 'home'
      expect(response).to be_success
    end

    it "gets the next three events" do
      event = double(:event)
      expect(Event).to receive(:limit).with(3).once.and_return([event])

      get :home

      expect(assigns(:events)).to eql [event]
    end

    it "gets the current basket" do
      get :home
      expect(assigns :basket).to be(basket)
    end

    context 'when there is an order ID in the session' do
      let(:order) { double(Order) }
      let(:order_id) { 1 }

      before do
        allow(Order).to receive(:find).with(order_id).and_return(order)
        session[:order_id] = order_id
      end

      it 'gets that order' do
        get :home
        expect(assigns(:order)).to be(order)
      end

      it 'removes the order ID from the session' do
        get :home
        expect(session[:order_id]).to be_nil
      end
    end

    context "when there is no basket ID in the session" do
      let(:session_basket) { nil }

      it "assigns a null basket" do
        get :home
        expect(assigns(:basket)).to be(null_basket)
      end
    end
  end

  describe 'GET "outlets"' do
    it 'should be successful' do
      get :outlets
      expect(response).to be_success
    end

    it "should have the right title" do
      get 'outlets'
      expect(assigns(:title)).to eql("Outlets")
    end
  end

  describe 'GET "products"' do
    it "gets all of the products" do
      product = double(:product)
      allow(Product).to receive(:all).and_return([product])

      get :products

      expect(assigns(:products)).to eql [product]
    end
  end
end
