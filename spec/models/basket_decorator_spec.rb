require "rails_helper"

describe BasketDecorator do
  subject(:decorator) { described_class.new(basket) }

  describe "#item_count" do
    let(:basket) { instance_double(Basket, line_items: line_items) }
    let(:line_items) do
      [
        instance_double(LineItem, quantity: 2),
        instance_double(LineItem, quantity: 1)
      ]
    end

    it "returns the total quantity of line items" do
      expect(decorator.item_count).to be 3
    end
  end

  describe "#line_items" do
    let(:basket) { instance_double(Basket, line_items: line_items) }
    let(:line_items) { [] }

    it "returns the basket's line items" do
      expect(decorator.line_items).to be(line_items)
    end
  end

  describe "#to_model" do
    let(:basket) { instance_double(Basket) }

    it "returns the basket" do
      expect(decorator.to_model).to be(basket)
    end
  end

  describe "#total_price" do
    let(:basket) { instance_double(Basket, total_price: total_price) }
    let(:total_price) { Money.new(1095) }

    it "returns the basket's total price" do
      expect(decorator.total_price).to be(total_price)
    end
  end
end
