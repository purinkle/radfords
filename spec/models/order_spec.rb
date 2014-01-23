require 'spec_helper'

describe Order do
  describe '#add_line_items_from_basket' do
    it 'adds the basket\'s items to line items' do
      item = LineItem.new
      basket = double(:basket)
      basket.stub(:line_items).once.with(no_args) { [item] }
      item.stub(:basket_id=).once.with(nil)

      order = Order.new
      order.add_line_items_from_basket(basket)

      expect(order.line_items).to have(1).item
    end
  end
end
