require 'spec_helper'

describe ProductsController do
  describe 'GET "new"' do
    let(:product) { stub }

    before do
      controller.stub(:authenticate)
      Product.stub(new: product)
    end

    it 'creates a new Product instance' do
      get :new
      assigns(:product).should == product
    end
  end
end
