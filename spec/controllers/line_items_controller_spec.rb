require 'spec_helper'

describe LineItemsController do
  describe 'POST "create"' do
    let(:basket) { double(Basket, save: nil) }
    let(:basket_url) { '/basket/1' }
    let(:product) { double(Product, id: product_id) }
    let(:product_id) { '1' }

    before do
      allow(basket).to receive(:add_product).with(product_id).and_return(basket)
      allow(controller).to receive(:current_basket).and_return(basket)
      allow(controller).to receive(:url_for).with(basket).and_return(basket_url)
      allow(Product).to receive(:find).with(product_id).and_return(product)
    end

    it 'redirects to the saved basket' do
      post :create, product_id: product_id
      expect(response).to redirect_to(root_url)
    end
  end
end
