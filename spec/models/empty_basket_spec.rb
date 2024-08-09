require "rails_helper"

describe EmptyBasket do
  describe "#line_items" do
    it "is empty" do
      empty_basket = EmptyBasket.new

      line_items = empty_basket.line_items

      expect(line_items).to be_empty
    end
  end

  describe "#to_partial_path" do
    it "is the partial to render the empty basket" do
      empty_basket = EmptyBasket.new

      partial_path = empty_basket.to_partial_path

      expect(partial_path).to eq "empty_basket"
    end
  end
end
