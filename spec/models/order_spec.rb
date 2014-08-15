require 'spec_helper'

describe Order do
  let(:order) { Order.new }

  describe '#add_line_items_from_basket' do
    let(:basket) { double("Basket", line_items: [item]) }
    let(:item) { double("LineItem") }

    before do
      allow(order).to receive(:line_items).and_return([])
    end

    it "clears the item's basket ID" do
      expect(item).to receive(:basket_id=).with(nil)
      order.add_line_items_from_basket(basket)
    end
  end

  describe '#total_price' do
    subject { order.total_price }

    let(:item_1) { double(LineItem, total_price: Money.new(395)) }
    let(:item_2) { double(LineItem, total_price: Money.new(1485)) }

    before do
      allow(order).to receive(:line_items).and_return([item_1, item_2])
    end

    it "returns the sum of each line item's total price" do
      expect(subject).to eql(Money.new(1880))
    end
  end
end
