require 'spec_helper'

describe ProductsController do
  before do
    controller.stub(:authenticate)
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

  describe 'POST "create"' do
    let(:params) { {} }
    let(:product) { stub(save: save) }

    before do
      Product.stub(:new).with(params) { product }
      post :create, product: params
    end

    context 'when the Product is invalid' do
      let(:save) { false }

      it 'renders the "New Product" page' do
        subject
        response.should render_template('new')
      end
    end
  end
end
