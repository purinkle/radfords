require 'spec_helper'

describe Order do
  let(:order) { Order.new }

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

  describe '#total_price' do
    subject { order.total_price }

    let(:item_1) { double(LineItem, total_price: Money.new(395)) }
    let(:item_2) { double(LineItem, total_price: Money.new(1485)) }

    before do
      order.stub(line_items: [item_1, item_2])
    end

    it "returns the sum of each line item's total price" do
      expect(subject).to eql(Money.new(1880))
    end
  end
end
