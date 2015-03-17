require 'spec_helper'

describe BasketsController do
  describe 'GET "show"' do
    let(:basket) { double("Basket") }
    let(:basket_id) { "1" }

    before do
      allow(FindBasket).to receive(:call).with(id: basket_id).
        and_return(basket)
    end

    it 'finds the basket' do
      get :show, nil, basket_id: basket_id
      expect(assigns(:basket)).to be(basket)
    end
  end

  describe 'DELETE "destroy"' do
    it 'redirects to the shop' do
      allow(Basket).to receive(:find).with(nil).and_raise(ActiveRecord::RecordNotFound)
      delete :destroy, id: '1'
      expect(response).to redirect_to shop_url
    end
  end
end
