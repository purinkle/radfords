require 'spec_helper'

describe ProductsController do
  before do
    controller.stub(:authenticate)
  end

  describe 'GET "delete"' do
    let(:id) { 'foo' }
    let(:params) { {id: id} }

    before do
      Product.stub(:find).with(id) { product }
    end

    context 'when no product is found' do
      let(:product) { raise ActiveRecord::RecordNotFound }

      it 'redirects to the index products page' do
        get :delete, params
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe 'DELETE "destroy"' do
    let(:id) { 'foo' }
    let(:params) { {id: id} }
    let(:product) { double(:product, destroy: nil) }

    before do
      Product.stub(:find).with(id) { product }
    end

    it 'destroys the product' do
      product.should_receive(:destroy)
      delete :destroy, params
    end

    it 'sets the notice flash' do
      delete :destroy, params
      expect(flash[:notice]).to eql('Product was deleted.')
    end

    it 'redirects to the index products page' do
      delete :destroy, params
      expect(response).to redirect_to(products_url)
    end
  end

  describe 'GET "edit"' do
    let(:id) { 'foo' }
    let(:params) { {id: id} }
    let(:product) { double(:product) }

    before do
      stub_const('Product', product)
      product.stub(:find).with(id) { found_product }
    end

    context 'when a product is found' do
      let(:found_product) { double(:found_product) }

      it 'stores the found product' do
        get :edit, params
        expect(assigns(:product)).to eql(found_product)
      end
    end

    context 'when no product is found' do
      let(:found_product) { raise ActiveRecord::RecordNotFound }

      it 'redirects to the product index page' do
        get :edit, params
        response.should redirect_to(products_path)
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
      Product.stub(new: product)
      get :new
    end

    it 'creates a new Product instance' do
      assigns(:product).should == product
    end
  end

  describe 'GET "show"' do
    let(:id) { 'foo' }
    let(:found_product) { double(:found_product) }
    let(:product) { double(:product) }

    before do
      product.stub(:find).with(id) { found_product }
      stub_const('Product', product)
    end

    it 'finds the relevant Product' do
      get :show, id: id
      expect(assigns(:product)).to eql(found_product)
    end

    context 'when no product is found' do
      let(:found_product) { raise ActiveRecord::RecordNotFound }

      it 'redirects to the product index page' do
        get :show, id: id
        response.should redirect_to(products_path)
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
      product.stub(save!: true, url_for: "")
      controller.stub(:authenticate)
      Product.stub(new: product)

      post :create, product: {}

      expect(assigns(:product)).to be product
    end

    it "sets the notice flash" do
      product = Product.new
      product.stub(save!: true, url_for: "")
      controller.stub(:authenticate)
      Product.stub(new: product)

      post :create, product: {}

      expect(flash[:notice]).to eql "You successfully created a product."
    end

    it "redirects to the product's page" do
      product = Product.new
      product.stub(save!: true, url_for: "")
      controller.stub(:authenticate)
      Product.stub(new: product)

      post :create, product: {}

      expect(response).to redirect_to product
    end

    context "when the product is invalid" do
      it "renders the new product page" do
        product = Product.new
        exception = ActiveRecord::RecordInvalid.new(product)
        product.stub(:save!).and_raise(exception)
        controller.stub(:authenticate)
        Product.stub(new: product)

        post :create, product: {}

        expect(response).to render_template "new"
      end
    end
  end

  describe 'PUT "update"' do
    let(:found_product) { double(:found_product) }
    let(:id) { 'foo' }
    let(:params) { {} }
    let(:product) { double(:product) }
    let(:title) { double(:title) }
    let(:update_attributes) { true }

    before do
      found_product.stub(:update_attributes).with(params) do
        update_attributes
      end

      found_product.stub(title: title)
      product.stub(:find).with(id) { found_product }
      stub_const('Product', product)
    end

    it 'finds the product' do
      put :update, id: id, product: params
      expect(assigns(:product)).to eql(found_product)
    end

    it 'updates the alert flash' do
      put :update, id: id, product: params
      expect(flash[:notice]).to eql('Product saved.')
    end

    it 'redirects to the show product page' do
      put :update, id: id, product: params
      response.should redirect_to(product_path(found_product))
    end

    context 'when the product is not valid' do
      let(:update_attributes) { false }

      it 'renders the edit product page' do
        put :update, id: id, product: params
        response.should render_template('edit')
      end
    end
  end
end
