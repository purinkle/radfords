require "rails_helper"

describe Product do
  let(:product) { build(:product) }

  describe "#to_s" do
    it "returns the title" do
      expect(product.to_s).to eql(product.title)
    end
  end

  describe "#destroy" do
    let(:product) { create(:product) }

    it "deletes a product no basket holds" do
      expect(product.destroy).to be_destroyed
    end

    context "when a basket holds the product" do
      before { create(:basket).line_items.create!(product: product) }

      it "refuses, and says why", :aggregate_failures do
        expect(product.destroy).to be(false)
        expect(product.errors.full_messages).to eq(["Line Items present"])
      end
    end
  end
end
