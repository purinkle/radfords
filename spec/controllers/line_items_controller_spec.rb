require "rails_helper"

describe LineItemsController do
  describe 'POST "create"' do
    let(:basket) { double(Basket, save: nil) }
    let(:product) { double(Product, id: product_id) }
    let(:product_id) { '1' }

    before do
      allow(basket).to receive(:add_product).with(product_id).and_return(basket)
      allow(controller).to receive(:current_basket).and_return(basket)
      allow(Product).to receive(:find).with(product_id).and_return(product)
    end

    it 'redirects to the saved basket' do
      products = class_double("Product")
      allow(Product).to receive(:friendly).and_return(products)
      allow(products).to receive(:find).and_return(product)

      post :create, params: { product_id: product_id }

      expect(response).to redirect_to(basket_url)
    end
  end

  describe "DELETE 'destroy'" do
    let(:id) { "1" }
    let(:item) { double("LineItem", destroy: nil) }
    let(:params) { { id: id } }

    before { allow(LineItem).to receive(:find).with(id).and_return item }

    it "destroys the line item" do
      delete :destroy, params: params

      expect(item).to have_received :destroy
    end

    it "redirects to the home page" do
      delete :destroy, params: params

      expect(response).to redirect_to basket_url
    end
  end

  describe "PUT 'update'" do
    let(:id) { "1" }
    let(:item) { double "LineItem" }
    let(:item_params) { { "quantity" => "2" } }
    let(:params) { { id: id, line_item: item_params } }

    before do
      allow(item).to receive(:update_attributes).with item_params
      allow(LineItem).to receive(:find).with(id).and_return item
    end

    it "updates the line item" do
      allow(item).to receive(:update_attributes)

      put :update, params: params

      expect(item).to have_received(:update_attributes)
    end

    it "redirects to the home page" do
      allow(item).to receive(:update_attributes)

      put :update, params: params

      expect(response).to redirect_to basket_url
    end
  end
end
