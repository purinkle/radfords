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

  context '#total_price' do
    let(:array) { stub(sum: nil) }
    let(:basket) { Basket.new }
    let(:item_1) { stub(total_price: nil) }
    let(:item_2) { stub(total_price: nil) }
    let(:line_items) { stub(to_a: array) }

    before(:each) do
      array.stub(:sum).and_yield(item_1).and_yield(item_2)
      basket.stub(line_items: line_items)
    end

    it 'exists' do
      basket.should respond_to(:total_price)
    end

    it 'gets the items' do
      basket.should_receive(:line_items)
      basket.total_price
    end

    it 'converts the items to an array' do
      line_items.should_receive(:to_a)
      basket.total_price
    end

    it 'sums the items' do
      array.should_receive(:sum)
      basket.total_price
    end

    it 'gets the total price of each item' do
      item_1.should_receive(:total_price)
      item_2.should_receive(:total_price)
      basket.total_price
    end
  end

  context '#total_items' do
    let(:basket) { Basket.new }
    let(:item_1) { stub(quantity: 1) }
    let(:item_2) { stub(quantity: 2) }

    before(:each) do
      basket.stub(line_items: [item_1, item_2])
    end

    it 'gets all the items' do
      basket.should_receive(:line_items)
      basket.total_items
    end

    it 'gets the quantity of each item' do
      item_1.should_receive(:quantity)
      item_2.should_receive(:quantity)
      basket.total_items
    end

    it 'returns the total number of items' do
      basket.total_items.should == 3
    end
  end
end
