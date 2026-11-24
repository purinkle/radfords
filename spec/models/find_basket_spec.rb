require "rails_helper"

describe FindBasket do
  describe ".call" do
    subject(:found) { described_class.call(options) }

    let(:basket) { instance_double(Basket) }
    let(:empty_basket) { instance_double(EmptyBasket) }
    let(:options) { { id: "1" } }

    before do
      allow(Basket).to receive(:with_line_items).and_return(Basket)
      allow(Basket).to receive(:where).with(options).and_return([basket])
      allow(EmptyBasket).to receive(:new).and_return(empty_basket)
    end

    it "returns the found basket" do
      expect(found).to be(basket)
    end

    context "when a basket can't be found" do
      let(:basket) { nil }

      it "returns a missing basket" do
        expect(found).to be(empty_basket)
      end
    end
  end
end
