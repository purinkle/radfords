require "rails_helper"

describe Basket do
  describe "#add_product" do
    subject(:item) { basket.add_product(product.id) }

    let(:basket) { create(:basket) }
    let(:product) { create(:product) }

    context "when the product is already in the basket" do
      let!(:found_item) { basket.line_items.create!(product: product, quantity: 1) }

      it "returns the found item" do
        expect(item).to eq(found_item)
      end
    end

    context "when no item is found" do
      it "returns a new item" do
        expect(item).to be_new_record.and have_attributes(product_id: product.id)
      end
    end
  end

  describe "#total_price" do
    it "returns the sum of the line items' prices" do
      basket = described_class.new
      line_items = [
        instance_double(LineItem, total_price: 300),
        instance_double(LineItem, total_price: 600)
      ]
      allow(basket).to receive(:line_items) { line_items }
      expect(basket.total_price).to be 900
    end
  end
end
