require 'spec_helper'

describe Basket do
  it 'has many line items' do
    should have_many(:line_items).dependent(:destroy)
  end

  context '#add_product' do
    let(:current_item) {stub}
    let(:line_items) {stub}
    let(:product_id) {stub}
    let(:new_quantity) {stub}
    let(:quantity) {stub}

    before(:each) do
      quantity.stub(:+ => new_quantity)
      current_item.stub(
        quantity: quantity,
        :quantity= => nil
      )
      line_items.stub(
        find_by_product_id: current_item,
        build: current_item
      )
      Basket.any_instance.stub(line_items: line_items)
    end

    it 'exists' do
      should respond_to(:add_product)
    end

    it 'tries to find a item by its product id' do
      basket = Basket.new
      basket.line_items.should_receive(:find_by_product_id).with(product_id)
      basket.add_product(product_id)
    end

    context 'when an item is found' do
      it 'gets the item quantity' do
        current_item.should_receive(:quantity)
        basket = Basket.new
        basket.add_product(product_id)
      end

      it 'increases the item quantity' do
        quantity.should_receive(:+).with(1)
        basket = Basket.new
        basket.add_product(product_id)
      end

      it 'stores the new item quantity' do
        current_item.should_receive(:quantity=).with(new_quantity)
        basket = Basket.new
        basket.add_product(product_id)
      end
    end

    context 'when no item is found' do
      before(:each) do
        line_items.stub(find_by_product_id: false)
      end

      it 'builds a new item' do
        line_items.should_receive(:build).with(product_id: product_id)
        basket = Basket.new
        basket.add_product(product_id)
      end
    end

    it 'returns the current item' do
      basket = Basket.new
      basket.add_product(product_id).should == current_item
    end
  end
end
