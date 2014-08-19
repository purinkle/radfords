require "spec_helper"

describe OrderBuilder do
  describe ".build" do
    let(:order) do
      double("Order", email: email, id: id, total_price: total_price)
    end

    let(:email) { "alphonso@example.com" }
    let(:id) { 1 }
    let(:message) { double("Mail::Message", deliver: nil) }
    let(:price) { 395_00 }
    let(:stripe_token) { "test_stripe_token" }
    let(:total_price) { double("Money", cents: price) }

    before do
      allow(ChargesCustomers).to receive(:charge).
        with(email, stripe_token, price, id)
      allow(Mailer).to receive(:order_received).with(order).and_return message

      OrderBuilder.build(order, stripe_token)
    end

    it "charges the customer" do
      expect(ChargesCustomers).to have_received(:charge).
        with(email, stripe_token, price, id)
    end

    it "delivers the message" do
      expect(message).to have_received :deliver
    end
  end
end
