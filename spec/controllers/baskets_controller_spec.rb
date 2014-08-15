require 'spec_helper'

describe BasketsController do
  describe 'GET "show"' do
    it 'finds the basket' do
      basket = Basket.new
      allow(Basket).to receive(:find).with("1").and_return(basket)
      get :show, id: '1'
      expect(assigns(:basket)).to be basket
    end

    context 'when a basket can\'t be found' do
      it 'redirects to the shop' do
        allow(Basket).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)
        get :show, id: '1'
        expect(response).to redirect_to shop_url
      end

      it 'alerts the user' do
        allow(Basket).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)
        get :show, id: '1'
        expect(flash[:alert]).to eql I18n.t('baskets.show.alert')
      end
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
