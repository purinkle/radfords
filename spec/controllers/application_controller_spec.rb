require "rails_helper"

describe ApplicationController do
  describe '#authenticate' do
    context "when the user's not signed in" do
      before do
        allow(controller).to receive(:deny_access)
        allow(controller).to receive(:signed_in?) { false }
      end

      it 'denies access to the application' do
        expect(controller).to receive(:deny_access)
        controller.authenticate
      end
    end
  end

  describe "#find_basket" do
    let(:basket) { double("Basket") }
    let(:decorated_basket) { double("BasketDecorator") }
    let(:id) { "1" }

    before do
      session["basket_id"] = id
      allow(BasketDecorator).to receive(:new).with(basket).
        and_return(decorated_basket)
      allow(FindBasket).to receive(:call).with(id: id).and_return(basket)
    end

    it "returns the current user's basket" do
      expect(controller.find_basket).to be decorated_basket
    end
  end
end
