require "rails_helper"

describe PagesController do
  before (:each) do
    @base_title = "Radfords of Somerford"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      expect(response).to be_success
    end

    context 'when there is an order ID in the session' do
      let(:order) { double(Order) }
      let(:order_id) { 1 }

      before do
        allow(Order).to receive(:find).with(order_id).and_return(order)
        session[:order_id] = order_id
      end

      it 'removes the order ID from the session' do
        get :home
        expect(session[:order_id]).to be_nil
      end
    end
  end

  describe 'GET "outlets"' do
    it 'should be successful' do
      get :outlets
      expect(response).to be_success
    end
  end
end
