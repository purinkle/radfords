require "spec_helper"

describe BasketDecorator do
  let(:decorator) { BasketDecorator.new(basket) }

  describe ".model_name" do
    let(:model_name) { double("ActiveModel::Name") }

    before { allow(Basket).to receive(:model_name).and_return(model_name) }

    it "returns the model name of the basket" do
      expect(BasketDecorator.model_name).to be(model_name)
    end
  end

  describe "#item_count" do
    let(:basket) { double("Basket", line_items: line_items) }
    let(:item_1) { double("LineItem", quantity: 2) }
    let(:item_2) { double("LineItem", quantity: 1) }
    let(:line_items) { [item_1, item_2] }

    it "returns the total quantity of line items" do
      expect(decorator.item_count).to eql 3
    end
  end

  describe "#line_items" do
    let(:basket) { double("Basket", line_items: line_items) }
    let(:line_items) { [] }

    it "returns the basket's line items" do
      expect(decorator.line_items).to be(line_items)
    end
  end

  describe "#to_partial_path" do
    subject { decorator.to_partial_path }

    let(:line_items) { [] }
    let(:partial_path) { "baskets/basket" }

    let(:basket) do
      double("Basket", line_items: line_items, to_partial_path: partial_path)
    end

    it "returns 'empty_basket'" do
      expect(subject).to eql("empty_basket")
    end

    context "when the basket has items" do
      let(:line_items) { [double("LineItem")] }

      it "returns the basket's partial path" do
        expect(subject).to eql(partial_path)
      end
    end
  end

  describe "#total_price" do
    let(:basket) { double("Basket", total_price: total_price) }
    let(:total_price) { double("Money") }

    it "returns the basket's total price" do
      expect(decorator.total_price).to be(total_price)
    end
  end
end
