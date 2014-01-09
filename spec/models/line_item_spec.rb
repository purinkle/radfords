require 'spec_helper'

describe LineItem do
  describe '#total_price' do
    it 'returns the product price multiplied by its quantity' do
      line_item = LineItem.new
      product = double
      line_item.stub(:product).once.with(no_args) { product }
      line_item.stub(:quantity).once.with(no_args) { 4 }
      product.stub(:price).once.with(no_args) { 300 }
      expect(line_item.total_price).to eql 1200
    end
  end
end
