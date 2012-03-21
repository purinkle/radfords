require 'spec_helper'

describe ProductsController do
  let(:id) { 1 }

  describe 'GET "index"' do
    let(:products) { stub }

    before(:each) do
      Product.stub(all: products)
      ProductDecorator.stub(decorate: products)
    end

    it 'is successful' do
      get :index

      response.should be_success
    end

    it 'sets the title to "Products"' do
      get :index

      assigns(:title).should == 'Products'
    end

    it 'gets the products' do
      Product.should_receive(:all)
      get :index
    end

    it 'decorates the products' do
      ProductDecorator.should_receive(:decorate).with(products)
      get :index
    end

    it 'stores the products' do
      get :index
      assigns(:products).should == products
    end
  end

  describe 'GET "new"' do
    context 'when signed in' do
      before(:each) do
        controller.stub(signed_in?: true)
      end

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

    context 'when not signed in' do
      it 'redirects to the sign in page' do
        get :new
        response.should redirect_to(signin_path)
      end

      it 'sets the error flash' do
        get :new
        flash[:error].should == 'Please sign in to access this page.'
      end
    end
  end

  describe 'POST "create"' do
    context 'when signed in' do
      let(:id) { 1 }
      let(:product) { mock_model(Product, id: id).as_null_object }

      before(:each) do
        Product.stub(new: product)
        product.stub(:save)
        controller.stub(signed_in?: true)
      end

      it 'creates a new product' do
        Product.should_receive(:new).with({})
        post :create, product: {}
      end

      it 'stores the new product' do
        post :create, product: {}
        assigns(:product).should == product
      end

      it 'tries to save the new product' do
        product.should_receive(:save)
        post :create, product: {}
      end

      context 'when the product is valid' do
        before(:each) do
          product.stub(save: true)
        end

        it 'creates a success flash' do
          post :create, product: {}
          flash[:success].should match(/created a new product/)
        end

        it 'redirects to the product\'s page' do
          post :create, product: {}
          response.should redirect_to(product_path(id))
        end
      end

      context 'when the product is invalid' do
        before(:each) do
          product.stub(save: false)
        end

        it 'sets the title' do
          post :create, product: {}
          assigns(:title).should == 'New Product'
        end

        it 'renders the new product page' do
          post :create, product: {}
          response.should render_template('new')
        end
      end
    end

    context 'when not signed in' do
      it 'redirects to the sign in page' do
        get :create, product: {}
        response.should redirect_to(signin_path)
      end

      it 'sets the error flash' do
        get :create, product: {}
        flash[:error].should == 'Please sign in to access this page.'
      end
    end

    it 'tries to save the new product' do
      product.should_receive(:save)
      post :create, product: {}
    end

    context 'when the product is valid' do
      before(:each) do
        product.stub(save: true)
      end

      it 'creates a success flash' do
        post :create, product: {}
        flash[:success].should match(/created a new product/)
      end

      it 'redirects to the product\'s page' do
        post :create, product: {}
        response.should redirect_to(product_path(id))
      end
    end

    context 'when the product is invalid' do
      before(:each) do
        product.stub(save: false)
      end

      it 'sets the title' do
        post :create, product: {}
        assigns(:title).should == 'New Product'
      end

      it 'renders the new product page' do
        post :create, product: {}
        response.should render_template('new')
      end
    end
  end

  describe 'GET "show"' do
    let (:attr) do
      { id: id }
    end

    let(:product) { stub(title: 'foo') }

    before(:each) do
      ProductDecorator.stub(find: product)
    end

    it 'is successful' do
      get :show, id: id
      response.should be_success
    end

    it 'sets the page title' do
      get :show, id: id
      assigns(:title).should == 'foo'
    end

    it 'decorates the product' do
      ProductDecorator.should_receive(:find).with(id)
      get :show, id: id
    end

    it 'finds the right product' do
      get :show, id: id
      assigns(:product).should == product
    end
  end

  describe 'GET "edit"' do
    before(:each) do
      @product = mock_model(Product)
      Product.stub(:find).with(id).and_return(@product)
    end

    context 'when signed in' do
      before(:each) do
        controller.stub(signed_in?: true)
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

    context 'when not signed in' do
      it 'redirects to the sign in page' do
        get :edit, id: id
        response.should redirect_to(signin_path)
      end

      it 'sets the error flash' do
        get :edit, id: id
        flash[:error].should == 'Please sign in to access this page.'
      end
    end
  end

  describe 'DELETE "destroy"' do
    before(:each) do
      @product = mock_model(Product)
      Product.stub(:find).with(id).and_return(@product)
    end

    context 'when signed in' do
      before(:each) do
        controller.stub(signed_in?: true)
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

      it 'creates a success flash' do
        post :destroy, id: id
        flash[:success].should match(/deleted the product/)
      end
    end

    context 'when not signed in' do
      it 'redirects to the sign in page' do
        post :destroy, id: id
        response.should redirect_to(signin_path)
      end

      it 'sets the error flash' do
        post :destroy, id: id
        flash[:error].should == 'Please sign in to access this page.'
      end
    end
  end

  describe 'PUT "update"' do
    let(:attr) { {} }
    let(:product) { mock_model(Product).as_null_object }

    before(:each) do
      Product.stub(find: product)
    end

    context 'when signed in' do
      before(:each) do
        controller.stub(signed_in?: true)
      end

      it 'finds the product' do
        Product.should_receive(:find).with(id)
        put :update, id: id, product: attr
      end

      it 'stores the product' do
        put :update, id: id, product: attr
        assigns(:product).should == product
      end

      it 'tries to update the product' do
        product.should_receive(:update_attributes).with(attr)
        put :update, id: id, product: attr
      end

      context 'when the product is updated' do
        it 'sets the notice flash' do
          put :update, id: id, product: attr
          flash[:success].should == 'Product was successfully updated.'
        end

        it 'redirects to the product\'s page' do
          put :update, id: id, product: attr
          response.should redirect_to(product)
        end
      end

      context 'when the product is not updated' do
        before(:each) do
          product.stub(update_attributes: false)
        end

        it 'sets the title' do
          put :update, id: id, product: attr
          assigns(:title).should == 'Edit Product'
        end

        it 'renders the edit product page' do
          put :update, id: id, product: attr
          response.should render_template('edit')
        end
      end
    end

    context 'when not signed in' do
      it 'redirects to the sign in page' do
        put :update, id: id, product: attr
        response.should redirect_to(signin_path)
      end

      it 'sets the error flash' do
        put :update, id: id, product: attr
        flash[:error].should == 'Please sign in to access this page.'
      end
    end
  end

  context '#check_title' do
    let(:title) { stub }

    before(:each) do
      Product.stub(:find_by_title)
      controller.stub(signed_in?: true)
    end

    it 'is successful' do
      get :check_title, title: title
      response.should be_success
    end

    it 'looks for a product with the title' do
      Product.should_receive(:find_by_title)
      get :check_title, title: title
    end

    context 'when the title is not found' do
      before(:each) do
        Product.stub(find_by_title: false)
      end

      it 'returns true' do
        get :check_title, title: title
        response.body.should == 'true'
      end
    end

    context 'when the title is not unique' do
      before(:each) do
        Product.stub(find_by_title: true)
      end

      it 'returns false' do
        get :check_title, title: title
        response.body.should == 'false'
      end
    end
  end
end
