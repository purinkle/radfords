require 'spec_helper'

describe LineItem do
  let(:item) { LineItem.new }

  describe '#total_price' do
    subject { item.total_price }

    let(:price) { 300 }
    let(:product) { double("Product", price: price) }
    let(:quantity) { 4 }
    let(:total_price) { price * quantity }

    before do
      allow(item).to receive(:product).and_return(product)
      allow(item).to receive(:quantity).and_return(quantity)
    end

    it 'returns the product price multiplied by its quantity' do
      expect(subject).to eql total_price
    end
  end
end
