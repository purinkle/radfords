require 'spec_helper'

describe ProductsController do
  let(:id) { 1 }

  describe 'GET "index"' do
    it 'is successful' do
      get :index

      response.should be_success
    end

    it 'sets the title to "Products"' do
      get :index

      assigns(:title).should == 'Products'
    end

    it 'should find the right products' do
      products = [mock_model(Product), mock_model(Product)]
      Product.should_receive(:all).and_return(products)
      get :index
      assigns(:products).should == products
    end
  end

  describe 'GET "new"' do
    it 'is successful' do
      get :new

      response.should be_success
    end

    it 'sets the title to "New Product"' do
      get :new

      assigns(:title).should == 'New Product'
    end

    it 'creates a new Product record' do
      get :new

      assigns(:product).should be_new_record
    end
  end

  describe 'POST "create"' do
    let(:product) { mock_model(Product, id: id).as_null_object }

    it 'redirects to the product show page' do
      Product.should_receive(:create).and_return(product);

      post :create, product: {}

      response.should redirect_to(product_path(id))
    end
  end

  describe 'GET "show"' do
    let (:attr) do
      { id: id }
    end

    it 'is successful' do
      product = mock_model(Product, attr).as_null_object
      Product.stub(:find).with(id).and_return(product)
      get :show, id: id
      response.should be_success
    end

    it 'sets the page title' do
      product = mock_model(Product, attr.merge(title: 'Lorem Ipsum'))
      Product.stub(:find).with(id).and_return(product)
      get :show, id: id
      assigns(:title).should == 'Lorem Ipsum'
    end

    it 'finds the right product' do
      product = mock_model(Product, attr).as_null_object
      Product.stub(:find).with(id).and_return(product)
      get :show, id: id
      assigns(:product).should == product
    end
  end

  describe 'GET "edit"' do
    before(:each) do
      @product = mock_model(Product)
      Product.stub(:find).with(id).and_return(@product)
    end

    it 'is successful' do
      get :edit, id: id
      response.should be_success
    end

    it 'sets the page title' do
      get :edit, id: id
      assigns(:title).should == 'Edit Product'
    end

    it 'finds the right product' do
      get :edit, id: id
      assigns(:product).should == @product
    end
  end

  describe 'DELETE "destroy"' do
    before(:each) do
      @product = mock_model(Product)
      Product.stub(:find).with(id).and_return(@product)
    end

    it 'redirects to the index' do
      delete :destroy, id: id
      response.should redirect_to(products_path)
    end

    it 'finds the right product' do
      delete :destroy, id: id
      assigns(:product).should == @product
    end

    it 'destroys the product' do
      @product.should_receive(:destroy)
      delete :destroy, id: id
    end
  end
end
