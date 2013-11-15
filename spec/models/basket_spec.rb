require 'spec_helper'

describe Basket do
  describe '#add_product' do
    it 'returns the current item' do
      basket = Basket.new
      current_item = double
      line_items = double
      basket.stub(:line_items).once.with(no_args) { line_items }
      current_item.stub(:quantity).once.with(no_args) { 1 }
      current_item.stub(:quantity=).once.with(2)
      line_items.stub(:find_by_product_id).with(3) { current_item }
      product = basket.add_product(3)
      expect(product).to be current_item
    end
  end

  describe '#total_price' do
    it 'returns the sum of the line items\' prices' do
      basket = Basket.new
      item_1 = double
      item_2 = double
      item_1.stub(:total_price).once.with(no_args) { 300 }
      item_2.stub(:total_price).once.with(no_args) { 600 }
      basket.stub(:line_items).once.with(no_args) { [item_1, item_2] }
      expect(basket.total_price).to eql 900
    end
  end
end
