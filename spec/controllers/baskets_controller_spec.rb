require 'spec_helper'

describe BasketsController do
  describe 'GET "show"' do
    it 'finds the basket' do
      basket = Basket.new
      Basket.stub(:find).once.with('1') { basket }
      get :show, id: '1'
      expect(assigns(:basket)).to be basket
    end

    context 'when a basket can\'t be found' do
      it 'redirects to the shop' do
        Basket.stub(:find).once.with('1') do
          raise ActiveRecord::RecordNotFound
        end
        get :show, id: '1'
        expect(response).to redirect_to shop_url
      end

      it 'alerts the user' do
        Basket.stub(:find).once.with('1') do
          raise ActiveRecord::RecordNotFound
        end
        get :show, id: '1'
        expect(flash[:alert]).to eql I18n.t('baskets.show.alert')
      end
    end
  end

  describe 'DELETE "destroy"' do
    it 'redirects to the shop' do
      basket = double(:basket)
      Basket.stub(:find).once.with(nil) { raise ActiveRecord::RecordNotFound }
      Basket.stub(:create).once.with(no_args) { basket }
      basket.stub(:id).once.with(no_args) { 1 }
      basket.stub(:destroy).once.with(no_args)
      delete :destroy, id: '1'
      expect(response).to redirect_to shop_url
    end
  end
end
