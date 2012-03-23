require 'spec_helper'

describe LineItemsController do
  context '#create' do
    let(:line_item) { stub(basket: stub(id: basket_id), save: nil) }
    let(:basket) { stub(id: basket_id, line_items: stub(build: line_item)) }
    let(:basket_id) { stub }
    let(:product) { stub }
    let(:product_id) { stub }

    before(:each) do
      Basket.stub(find: basket)
      Product.stub(find: product)
    end

    it 'tries to find the current basket' do
      controller.stub(session: {basket_id: basket_id})
      Basket.should_receive(:find).with(basket_id)
      post :create, line_item: {}
    end

    context 'when no basket is found' do
      before(:each) do
        Basket.stub(:find).and_raise(ActiveRecord::RecordNotFound)
        Basket.stub(create: basket)
      end

      it 'creates a new basket' do
        Basket.should_receive(:create)
        post :create, line_item: {}
      end

      it 'gets the basket\'s id' do
        basket.should_receive(:id)
        post :create, line_item: {}
      end

      it 'stores the basket id' do
        post :create, line_item: {}
        session[:basket_id].should == basket_id
      end
    end

    it 'stores the basket' do
      post :create, line_item: {}
      assigns(:basket).should == basket
    end

    it 'tries to find the product' do
      Product.should_receive(:find).with(product_id)
      post :create, product_id: product_id
    end

    it 'builds the basket' do
      basket.line_items.should_receive(:build).with(product: product)
      post :create, product_id: product_id
    end

    it 'stores the line item' do
      post :create, product_id: product_id
      assigns(:line_item).should == line_item
    end

    it 'tries to save the line item' do
      line_item.should_receive(:save)
      post :create, product_id: product_id
    end

    it 'gets the line item\'s basket' do
      line_item.should_receive(:basket)
      post :create, product_id: product_id
    end

    it 'redirects to the line item\'s basket' do
      post :create, product_id: product_id
      response.should redirect_to(basket_path(basket_id))
    end
  end
end
