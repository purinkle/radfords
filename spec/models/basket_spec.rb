require "rails_helper"

describe Basket do
  let(:basket) { Basket.new }

  describe '#add_product' do
    subject { basket.add_product(product_id) }

    let(:found_item) { double(LineItem, :quantity => 1, :quantity= => nil) }
    let(:new_item) { double(LineItem) }
    let(:product_id) { '1' }

    before do
      allow(basket).to receive(:line_items) { LineItem }
      allow(LineItem).to receive(:build).with(product_id: product_id).
        and_return(new_item)
      allow(LineItem).to receive(:find_by_product_id).with(product_id).
        and_return(found_item)
    end

    it 'returns the found item' do
      expect(subject).to be(found_item)
    end

    context 'when no item is found' do
      let(:found_item) { nil }

      it 'returns a new item' do
        expect(subject).to be(new_item)
      end
    end
  end

  describe '#total_price' do
    it 'returns the sum of the line items\' prices' do
      basket = Basket.new
      item_1 = double("LineItem", total_price: 300)
      item_2 = double("LineItem", total_price: 600)
      allow(basket).to receive(:line_items) { [item_1, item_2] }
      expect(basket.total_price).to eql 900
    end
  end
end
