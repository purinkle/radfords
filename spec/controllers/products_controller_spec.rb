require "rails_helper"

describe ProductsController do
  let(:product_params) do
    {
      "description" => "Description of the jam",
      "title" => "Jam"
    }
  end

  before do
    allow(controller).to receive(:authenticate)
  end

  describe 'GET "delete"' do
    context "when no product is found" do
      it "redirects to the index products page" do
        get :delete, params: { id: "foo" }

        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe 'DELETE "destroy"' do
    let!(:product) { create(:product) }

    it "destroys the product" do
      expect { delete :destroy, params: { id: product.slug } }
        .to change(Product, :count).by(-1)
    end

    it "redirects to the products index" do
      delete :destroy, params: { id: product.slug }

      expect(response).to redirect_to products_url
    end

    it "sets the notice flash" do
      delete :destroy, params: { id: product.slug }

      expect(flash[:notice]).to eql I18n.t("products.destroy.notice")
    end

    context "when the product can't be found" do
      it "redirects to the products index" do
        delete :destroy, params: { id: "missing" }

        expect(response).to redirect_to products_url
      end

      it "sets the alert flash" do
        delete :destroy, params: { id: "missing" }

        expect(flash[:alert]).to eql I18n.t("products.destroy.alert")
      end
    end
  end

  describe 'GET "edit"' do
    context "when no product is found" do
      it "redirects to the product index page" do
        get :edit, params: { id: "missing" }

        expect(response).to redirect_to(products_path)
      end

      it "sets the alert flash" do
        get :edit, params: { id: "missing" }

        expect(flash[:alert]).to eql("We couldn't find that product.")
      end
    end
  end

  describe 'GET "show"' do
    context "when no product is found" do
      it "redirects to the product index page" do
        get :show, params: { id: "missing" }

        expect(response).to redirect_to(products_path)
      end

      it "sets the alert flash" do
        get :show, params: { id: "missing" }

        expect(flash[:alert]).to eql("We couldn't find that product.")
      end
    end
  end

  describe "POST 'create'" do
    let(:product) { Product.new }

    before do
      allow(product).to receive(:save!).and_return(true)
      allow(Product).to receive(:new).and_return(product)
    end

    it "sets the notice flash" do
      post :create, params: { product: product_params }

      expect(flash[:notice]).to eql "You successfully created a product."
    end

    it "redirects to the product's page" do
      post :create, params: { product: product_params }

      expect(response).to redirect_to product
    end
  end

  describe 'PUT "update"' do
    let(:product) { create(:product) }

    it "updates the alert flash" do
      put :update, params: { id: product.slug, product: product_params }

      expect(flash[:notice]).to eql("Product saved.")
    end

    it "redirects to the show product page" do
      put :update, params: { id: product.slug, product: product_params }

      expect(response).to redirect_to(product_path(product))
    end
  end
end
