require "rails_helper"

describe LineItem do
  let(:item) { described_class.new }

  describe "#total_price" do
    subject(:total_price) { item.total_price }

    let(:price) { 300 }
    let(:product) { instance_double(Product, price: price) }
    let(:quantity) { 4 }

    before do
      allow(item).to receive_messages(product: product, quantity: quantity)
    end

    it "returns the product price multiplied by its quantity" do
      expect(total_price).to eql price * quantity
    end
  end
end
