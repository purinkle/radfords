require "spec_helper"

describe MissingBasket do
  describe "#line_items" do
    let(:none) { double("ActiveRecord::Relation") }

    before do
      allow(LineItem).to receive(:none).and_return(none)
    end

    it "returns an 'None' relation" do
      expect(MissingBasket.new.line_items).to be none
    end
  end
end
