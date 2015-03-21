require "spec_helper"

describe MissingBasket do
  describe "#line_items" do
    it "returns an empty array" do
      expect(MissingBasket.new.line_items).to eql([])
    end
  end
end
