require 'spec_helper'

describe PagesController do
  before (:each) do
    @base_title = "Radfords of Somerford"
  end

  describe "GET 'home'" do
    let(:basket) { double("Basket") }

    before do
      controller.stub(current_basket: basket)
    end

    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "gets the next three events" do
      event = double(:event)
      Event.stub(:limit).with(3).once.and_return([event])

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
        Order.stub(:find).with(order_id).and_return(order)
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
  end

  describe 'GET "outlets"' do
    before(:each) do
      Supplier.any_instance.stub :geocode
      @supplier = FactoryGirl.create(:supplier)
      second = FactoryGirl.create(:supplier, address: '75 Lairg Road, Newcastle upon Type NE1 0TF', name: 'Jasmine Haynes', telephone_number: '070 0060 9200', website: 'http://marketingtickets.com/')
      third = FactoryGirl.create(:supplier, address: '27 Vicar Lane, Saron SA44 8HH', name: 'Jamie Hunter', telephone_number: '079 8825 0308', website: 'http://aromatherapyjobs.com/')
      @suppliers = [@supplier, second, third]

      30.times do
        @suppliers << FactoryGirl.create(:supplier)
      end
    end

    it 'should be successful' do
      get :outlets
      response.should be_success
    end

    it "should have the right title" do
      get 'outlets'
      expect(assigns(:title)).to eql("Outlets")
    end
  end

  describe 'GET "products"' do
    it "gets all of the products" do
      product = double(:product)
      Product.stub(:all).and_return([product])

      get :products

      expect(assigns(:products)).to eql [product]
    end
  end
end
