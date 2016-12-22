require "rails_helper"

describe BasketsController do
  describe 'GET "show"' do
    let(:basket) { double("Basket") }
    let(:basket_id) { "1" }
    let(:decorator) { double("BasketDecorator") }

    before do
      allow(BasketDecorator).to receive(:new).with(basket).
        and_return(decorator)
      allow(FindBasket).to receive(:call).with(id: basket_id).
        and_return(basket)
    end

    it "is successful" do
      get :show, session: { basket_id: basket_id }

      expect(response).to be_success
    end
  end

  describe 'DELETE "destroy"' do
    it 'redirects to the shop' do
      allow(Basket).to receive(:find).with(nil).and_raise(ActiveRecord::RecordNotFound)

      delete :destroy, params: { id: "1" }

      expect(response).to redirect_to basket_url
    end
  end
end
