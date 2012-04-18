require 'spec_helper'

describe LineItem do
  it 'belongs to a basket' do
    should belong_to(:basket)
  end

  it 'belongs to a product' do
    should belong_to(:product)
  end

  context '#total_price' do
    let(:line_item) { LineItem.new }
    let(:price) { stub(:* => result) }
    let(:product) { stub(price: price) }
    let(:quantity) { stub }
    let(:result) { stub }

    before(:each) do
      line_item.stub(quantity: quantity, product: product)
    end

    it 'exists' do
      should respond_to(:total_price)
    end

    it 'gets the quantity' do
      line_item.should_receive(:quantity)
      line_item.total_price
    end

    it 'gets the product price' do
      product.should_receive(:price)
      line_item.total_price
    end

    it 'calculates the total price' do
      price.should_receive(:*).with(quantity)
      line_item.total_price
    end

    it 'returns the total price' do
      line_item.total_price.should == result
    end
  end
end
