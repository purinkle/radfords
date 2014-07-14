require 'spec_helper'

describe LineItemsController do
  describe 'POST "create"' do
    let(:basket) { double(Basket, save: nil) }
    let(:basket_url) { '/basket/1' }
    let(:product) { double(Product, id: product_id) }
    let(:product_id) { '1' }

    before do
      basket.stub(:add_product).with(product_id).and_return(basket)
      controller.stub(current_basket: basket)
      controller.stub(:url_for).with(basket).and_return(basket_url)
      Product.stub(:find).with(product_id).and_return(product)
    end

    it 'redirects to the saved basket' do
      post :create, product_id: product_id
      expect(response).to redirect_to(root_url)
    end
  end
end
