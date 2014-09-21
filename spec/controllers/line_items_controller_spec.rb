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

  describe "DELETE 'destroy'" do
    let(:id) { "1" }
    let(:item) { double("LineItem", destroy: nil) }
    let(:params) { { id: id } }

    before { allow(LineItem).to receive(:find).with(id).and_return item }

    it "destroys the line item" do
      delete :destroy, params
      expect(item).to have_received :destroy
    end

    it "redirects to the home page" do
      delete :destroy, params
      expect(response).to redirect_to root_url
    end
  end

  describe "PUT 'update'" do
    let(:id) { "1" }
    let(:item) { double "LineItem" }
    let(:item_params) { { quantity: "2" } }
    let(:params) { { id: id, line_item: item_params } }

    before do
      allow(item).to receive(:update_attributes).with item_params
      allow(LineItem).to receive(:find).with(id).and_return item
    end

    it "updates the line item" do
      put :update, params
      expect(item).to have_received(:update_attributes).with item_params
    end

    it "redirects to the home page" do
      put :update, params
      expect(response).to redirect_to root_url
    end
  end
end
