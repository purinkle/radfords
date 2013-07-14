require 'spec_helper'

describe PagesController do
  before (:each) do
    @base_title = "Radfords of Somerford"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      expect(assigns(:title)).to eql("Home")
    end

    it "gets the next three events" do
      event = double(:event)
      Event.stub(:find).with(:all, limit: 3).and_return([event])

      get :home

      expect(assigns(:events)).to eql [event]
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

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      expect(assigns(:title)).to eql("Contact")
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
