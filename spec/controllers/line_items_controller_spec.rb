require 'spec_helper'

describe LineItemsController do
  describe 'POST "create"' do
    it 'gets the current basket' do
      basket = Basket.new
      product = Product.new
      session[:basket_id] = 2
      Basket.stub(:find).once.with(2) { basket }
      Product.stub(:find).once.with('1') { product }
      post :create, product_id: '1'
      expect(assigns(:basket)).to be basket
    end

    it 'saves the line item' do
      basket = Basket.new
      line_item = LineItem.new
      product = Product.new
      session[:basket_id] = 2
      basket.stub(:add_product).once.with(1) { line_item }
      product.stub(:id).once.with(no_args) { 1 }
      Basket.stub(:find).once.with(2) { basket }
      Product.stub(:find).once.with('1') { product }
      line_item.should_receive(:save).once.with(no_args)
      post :create, product_id: '1'
    end

    it 'redirects to the basket' do
      basket = Basket.new
      product = Product.new
      session[:basket_id] = 2
      Basket.stub(:find).once.with(2) { basket }
      Product.stub(:find).once.with('1') { product }
      post :create, product_id: '1'
      expect(response).to redirect_to basket
    end

    context 'when there is no current basket' do
      it 'creates a new basket' do
        basket = Basket.new
        product = Product.new
        basket.stub(:id).once.with(no_args) { 2 }
        Basket.stub(:create).once.with(no_args) { basket }
        Basket.stub(:find).once.with(nil) { raise ActiveRecord::RecordNotFound }
        Product.stub(:find).once.with('1') { product }
        post :create, product_id: '1'
        expect(assigns(:basket)).to be basket
      end

      it 'saves the line item to the new basket' do
        basket = Basket.new
        line_item = LineItem.new
        product = Product.new
        basket.stub(:add_product).once.with(1) { line_item }
        basket.stub(:id).once.with(no_args) { 2 }
        product.stub(:id).once.with(no_args) { 1 }
        Basket.stub(:create).once.with(no_args) { basket }
        Basket.stub(:find).once.with(nil) { raise ActiveRecord::RecordNotFound }
        Product.stub(:find).once.with('1') { product }
        line_item.should_receive(:save).once.with(no_args)
        post :create, product_id: '1'
      end

      it 'redirects to the new basket' do
        basket = Basket.new
        product = Product.new
        basket.stub(:id).once.with(no_args) { 2 }
        Basket.stub(:create).once.with(no_args) { basket }
        Basket.stub(:find).once.with(nil) { raise ActiveRecord::RecordNotFound }
        Product.stub(:find).once.with('1') { product }
        post :create, product_id: '1'
        expect(response).to redirect_to basket
      end
    end
  end
end
