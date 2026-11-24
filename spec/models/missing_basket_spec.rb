require "rails_helper"

describe MissingBasket do
  subject(:basket) { described_class.new }

  describe "#line_items" do
    let(:none) { instance_double(ActiveRecord::Relation) }

    before do
      allow(LineItem).to receive(:none).and_return(none)
    end

    it "returns an 'None' relation" do
      expect(basket.line_items).to be none
    end
  end
end
