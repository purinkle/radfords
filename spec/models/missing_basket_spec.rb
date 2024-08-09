require "rails_helper"

RSpec.describe MissingBasket do
  describe "#line_items" do
    it "is empty" do
      missing_basket = MissingBasket.new

      line_items = missing_basket.line_items

      expect(line_items).to be_empty
    end
  end
end
