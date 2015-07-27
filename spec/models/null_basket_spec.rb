require "rails_helper"

describe NullBasket do
  let(:basket) { NullBasket.new }

  describe "#line_items" do
    subject { basket.line_items }

    it "returns an empty array" do
      expect(subject).to eql([])
    end
  end
end
