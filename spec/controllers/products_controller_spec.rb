require 'spec_helper'

describe ProductsController do
  before do
    controller.stub(:authenticate)
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
    let(:product) { stub }

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
    let(:product) { stub }

    before do
      Product.stub(:find).with(id) { product }
    end

    it 'finds the relevant Product' do
      get :show, id: id
      assigns(:product).should == product
    end
  end

  describe 'POST "create"' do
    let(:id) { 'foo' }
    let(:params) { {} }
    let(:product) { stub(id: id, save: save) }

    before do
      Product.stub(:new).with(params) { product }
    end

    context 'when the Product is valid' do
      let(:save) { true }

      it 'redirects to the product\'s page' do
        post :create, product: params
        response.should redirect_to(product_path(id))
      end

      it 'sets the success flash' do
        post :create, product: params
        flash[:success].should == 'The product was created successfully.'
      end
    end

    context 'when the Product is invalid' do
      let(:save) { false }

      it 'renders the "New Product" page' do
        post :create, product: params
        response.should render_template('new')
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
