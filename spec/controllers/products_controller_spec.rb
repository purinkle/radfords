require "rails_helper"

describe ProductsController do
  let(:product_params) do
    {
      'description' => 'Description of the jam',
      'photo' => 'photo.jpg',
      'photo_file_name' => '/path/to/photo',
      'title' => 'Jam'
    }
  end

  before do
    allow(controller).to receive(:authenticate)
  end

  describe 'GET "delete"' do
    let(:id) { 'foo' }
    let(:params) { {id: id} }

    before do
      allow(Product).to receive(:find).with(id).and_raise(ActiveRecord::RecordNotFound)
    end

    context 'when no product is found' do
      it 'redirects to the index products page' do
        get :delete, params: params

        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe 'DELETE "destroy"' do
    it 'destroys the product' do
      products = class_double("Product")
      product = double(:product)
      allow(Product).to receive(:friendly).and_return(products)
      allow(product).to receive(:destroy).with(no_args).once.and_return(true)
      allow(products).to receive(:find).and_return(product)

      expect(product).to receive(:destroy).and_return(true)

      delete :destroy, params: { id: "1" }
    end

    it 'redirects to the products index' do
      product = double(:product)
      allow(product).to receive(:destroy).and_return(true)
      allow(Product).to receive(:find).with("1").and_return(product)

      delete :destroy, params: { id: "1" }

      expect(response).to redirect_to products_url
    end

    it 'sets the notice flash' do
      products = class_double("Product")
      product = double(:product)
      allow(Product).to receive(:friendly).and_return(products)
      allow(product).to receive(:destroy).with(no_args).once.and_return(true)
      allow(products).to receive(:find).and_return(product)

      delete :destroy, params: { id: "1" }

      expect(flash[:notice]).to eql I18n.t('products.destroy.notice')
    end

    context 'when the product can\'t be found' do
      it 'redirects to the products index' do
        allow(Product).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)

        delete :destroy, params: { id: "1" }

        expect(response).to redirect_to products_url
      end

      it 'sets the alert flash' do
        allow(Product).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)

        delete :destroy, params: { id: "1" }

        expect(flash[:alert]).to eql I18n.t('products.destroy.alert')
      end
    end
  end

  describe 'GET "edit"' do
    let(:found_product) { double(:found_product) }
    let(:id) { 'foo' }
    let(:invalid_id) { "2" }
    let(:params) { {id: id} }
    let(:product) { double(:product) }

    before do
      stub_const('Product', product)
      allow(product).to receive(:find).with(id).and_return(found_product)
      allow(product).to receive(:find).with(invalid_id).and_raise(ActiveRecord::RecordNotFound)
    end

    context 'when no product is found' do
      let(:id) { invalid_id }

      it 'redirects to the product index page' do
        products = class_double("Product")
        allow(Product).to receive(:friendly).and_return(products)
        allow(products).to receive(:find).
          and_raise(ActiveRecord::RecordNotFound)

        get :edit, params: params

        expect(response).to redirect_to(products_path)
      end

      it 'sets the alert flash' do
        products = class_double("Product")
        allow(Product).to receive(:friendly).and_return(products)
        allow(products).to receive(:find).
          and_raise(ActiveRecord::RecordNotFound)

        get :edit, params: params

        expect(flash[:alert]).to eql("We couldn't find that product.")
      end
    end
  end

  describe 'GET "show"' do
    let(:exception) { ActiveRecord::RecordNotFound }
    let(:id) { 'foo' }
    let(:invalid_id) { "2" }
    let(:found_product) { double(:found_product) }
    let(:product) { double(:product) }

    before do
      allow(product).to receive(:find).with(id).and_return(found_product)
      allow(product).to receive(:find).with(invalid_id).and_raise(exception)
      stub_const('Product', product)
    end

    context 'when no product is found' do
      let(:id) { invalid_id }

      it 'redirects to the product index page' do
        products = class_double("Product")
        allow(products).to receive(:find).and_raise(exception)
        allow(Product).to receive(:friendly).and_return(products)

        get :show, params: { id: id }

        expect(response).to redirect_to(products_path)
      end

      it 'sets the alert flash' do
        products = class_double("Product")
        allow(products).to receive(:find).and_raise(exception)
        allow(Product).to receive(:friendly).and_return(products)

        get :show, params: { id: id }

        expect(flash[:alert]).to eql("We couldn't find that product.")
      end
    end
  end

  describe "POST 'create'" do
    it "sets the notice flash" do
      product = Product.new
      allow(product).to receive(:save!).and_return(true)
      allow(controller).to receive(:authenticate)
      allow(Product).to receive(:new).and_return(product)

      post :create, params: { product: product_params }

      expect(flash[:notice]).to eql "You successfully created a product."
    end

    it "redirects to the product's page" do
      product = Product.new
      allow(product).to receive(:save!).and_return(true)
      allow(controller).to receive(:authenticate)
      allow(Product).to receive(:new).and_return(product)

      post :create, params: { product: product_params }

      expect(response).to redirect_to product
    end
  end

  describe 'PUT "update"' do
    let(:found_product) { double(:found_product) }
    let(:id) { 'foo' }
    let(:product) { double(:product) }
    let(:title) { double(:title) }
    let(:update_attributes) { true }

    before do
      allow(found_product).to receive(:update_attributes).
        and_return(update_attributes)

      allow(found_product).to receive(:title).and_return(title)
      allow(product).to receive(:find).with(id).and_return(found_product)
      stub_const('Product', product)
    end

    it 'updates the alert flash' do
      products = class_double("Product")
      allow(Product).to receive(:friendly).and_return(products)
      allow(products).to receive(:find).and_return(found_product)

      put :update, params: { id: id, product: product_params }

      expect(flash[:notice]).to eql('Product saved.')
    end

    it 'redirects to the show product page' do
      products = class_double("Product")
      allow(Product).to receive(:friendly).and_return(products)
      allow(products).to receive(:find).and_return(found_product)

      put :update, params: { id: id, product: product_params }

      expect(response).to redirect_to(product_path(found_product))
    end
  end
end
