require 'spec_helper'

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
        get :delete, params
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe 'DELETE "destroy"' do
    it 'sets the product' do
      product = double(:product)
      allow(product).to receive(:destroy).and_return(true)
      allow(Product).to receive(:find).with("1").and_return(product)

      delete :destroy, id: '1'

      expect(assigns(:product)).to be product
    end

    it 'destroys the product' do
      product = double(:product)
      allow(Product).to receive(:find).with("1").and_return(product)

      expect(product).to receive(:destroy).and_return(true)

      delete :destroy, id: '1'
    end

    it 'redirects to the products index' do
      product = double(:product)
      allow(product).to receive(:destroy).and_return(true)
      allow(Product).to receive(:find).with("1").and_return(product)

      delete :destroy, id: '1'

      expect(response).to redirect_to products_url
    end

    it 'sets the notice flash' do
      product = double(:product)
      allow(product).to receive(:destroy).with(no_args).once.and_return(true)
      allow(Product).to receive(:find).with("1").and_return(product)

      delete :destroy, id: '1'

      expect(flash[:notice]).to eql I18n.t('products.destroy.notice')
    end

    context 'when the product can\'t be found' do
      it 'redirects to the products index' do
        allow(Product).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)

        delete :destroy, id: '1'

        expect(response).to redirect_to products_url
      end

      it 'sets the alert flash' do
        allow(Product).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)

        delete :destroy, id: '1'

        expect(flash[:alert]).to eql I18n.t('products.destroy.alert')
      end
    end

    context 'when the product can\'t be destroyed' do
      it 'renders the delete view' do
        product = double(:product, destroy: false)
        allow(Product).to receive(:find).with("1").and_return(product)

        delete :destroy, id: '1'

        expect(response).to render_template :delete
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

    context 'when a product is found' do
      it 'stores the found product' do
        get :edit, params
        expect(assigns(:product)).to eql(found_product)
      end
    end

    context 'when no product is found' do
      let(:id) { invalid_id }

      it 'redirects to the product index page' do
        get :edit, params
        expect(response).to redirect_to(products_path)
      end

      it 'sets the alert flash' do
        get :edit, params
        expect(flash[:alert]).to eql("We couldn't find that product.")
      end
    end
  end

  describe 'GET "index"' do
    let(:product_class) { double(:product_class, all: products) }
    let(:products) { double(:products) }

    before do
      stub_const('Product', product_class)
    end

    it 'gets all of the prodcts' do
      get :index
      expect(assigns(:products)).to eql(products)
    end
  end

  describe 'GET "new"' do
    let(:product) { double }

    before do
      allow(Product).to receive(:new).and_return(product)
      get :new
    end

    it 'creates a new Product instance' do
      expect(assigns(:product)).to be(product)
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

    it 'finds the relevant Product' do
      get :show, id: id
      expect(assigns(:product)).to eql(found_product)
    end

    context 'when no product is found' do
      let(:id) { invalid_id }

      it 'redirects to the product index page' do
        get :show, id: id
        expect(response).to redirect_to(products_path)
      end

      it 'sets the alert flash' do
        get :show, id: id
        expect(flash[:alert]).to eql("We couldn't find that product.")
      end
    end
  end

  describe "POST 'create'" do
    it "finds the product" do
      product = Product.new
      allow(product).to receive(:save!).and_return(true)
      allow(product).to receive(:url_for).and_return("")
      allow(controller).to receive(:authenticate)
      allow(Product).to receive(:new).and_return(product)

      post :create, product: product_params

      expect(assigns(:product)).to be product
    end

    it "sets the notice flash" do
      product = Product.new
      allow(product).to receive(:save!).and_return(true)
      allow(product).to receive(:url_for).and_return("")
      allow(controller).to receive(:authenticate)
      allow(Product).to receive(:new).and_return(product)

      post :create, product: product_params

      expect(flash[:notice]).to eql "You successfully created a product."
    end

    it "redirects to the product's page" do
      product = Product.new
      allow(product).to receive(:save!).and_return(true)
      allow(product).to receive(:url_for).and_return("")
      allow(controller).to receive(:authenticate)
      allow(Product).to receive(:new).and_return(product)

      post :create, product: product_params

      expect(response).to redirect_to product
    end

    context "when the product is invalid" do
      it "renders the new product page" do
        product = Product.new
        exception = ActiveRecord::RecordInvalid.new(product)
        allow(product).to receive(:save!).and_raise(exception)
        allow(controller).to receive(:authenticate)
        allow(Product).to receive(:new).and_return(product)

        post :create, product: product_params

        expect(response).to render_template "new"
      end
    end
  end

  describe 'PUT "update"' do
    let(:found_product) { double(:found_product) }
    let(:id) { 'foo' }
    let(:product) { double(:product) }
    let(:title) { double(:title) }
    let(:update_attributes) { true }

    before do
      allow(found_product).to receive(:update_attributes).with(product_params).
        and_return(update_attributes)

      allow(found_product).to receive(:title).and_return(title)
      allow(product).to receive(:find).with(id).and_return(found_product)
      stub_const('Product', product)
    end

    it 'finds the product' do
      put :update, id: id, product: product_params
      expect(assigns(:product)).to eql(found_product)
    end

    it 'updates the alert flash' do
      put :update, id: id, product: product_params
      expect(flash[:notice]).to eql('Product saved.')
    end

    it 'redirects to the show product page' do
      put :update, id: id, product: product_params
      expect(response).to redirect_to(product_path(found_product))
    end

    context 'when the product is not valid' do
      let(:update_attributes) { false }

      it 'renders the edit product page' do
        put :update, id: id, product: product_params
        expect(response).to render_template("edit")
      end
    end
  end
end
