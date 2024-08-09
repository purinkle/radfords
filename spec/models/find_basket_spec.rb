require "rails_helper"

describe FindBasket do
  describe ".call" do
    subject { FindBasket.call(options) }

    let(:basket) { double("Basket") }
    let(:empty_basket) { double("EmptyBasket") }
    let(:options) { { id: "1" } }

    before do
      allow(Basket).to receive(:where).with(options).and_return([basket])
      allow(EmptyBasket).to receive(:new).and_return(empty_basket)
    end

    it "returns the found basket" do
      expect(subject).to be(basket)
    end

    context "when a basket can't be found" do
      let(:basket) { nil }

      it "returns a missing basket" do
        expect(subject).to be(empty_basket)
      end
    end
  end
end
