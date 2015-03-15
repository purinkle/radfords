require 'spec_helper'

describe BasketsController do
  describe 'GET "show"' do
    let(:basket) { double("Basket") }
    let(:basket_id) { "1" }

    before do
      allow(Basket).to receive(:find).with(basket_id).and_return(basket)
    end

    it 'finds the basket' do
      get :show, nil, basket_id: basket_id
      expect(assigns(:basket)).to be(basket)
    end

    context 'when a basket can\'t be found' do
      before do
        allow(Basket).to receive(:find).with(basket_id).
          and_raise(ActiveRecord::RecordNotFound)
      end

      it 'redirects to the shop' do
        get :show, nil, basket_id: basket_id
        expect(response).to redirect_to(shop_url)
      end

      it 'alerts the user' do
        get :show, nil, basket_id: basket_id
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
