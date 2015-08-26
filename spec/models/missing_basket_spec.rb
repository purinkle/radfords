require "rails_helper"

describe MissingBasket do
  subject(:basket) { MissingBasket.new }

  describe "#line_items" do
    let(:none) { double("ActiveRecord::Relation") }

    before do
      allow(LineItem).to receive(:none).and_return(none)
    end

    it "returns an 'None' relation" do
      expect(basket.line_items).to be none
    end
  end

  describe "#to_partial_path" do
    it "returns 'empty_basket'" do
      expect(basket.to_partial_path).to eql("empty_basket")
    end
  end
end
