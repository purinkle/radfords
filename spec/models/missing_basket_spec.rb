require "spec_helper"

describe MissingBasket do
  describe "#to_partial_path" do
    it "returns 'empty_basket'" do
      expect(subject.to_partial_path).to eql("empty_basket")
    end
  end
end
