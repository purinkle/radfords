require "rails_helper"

describe OrderBuilder do
  describe ".build" do
    let(:order) do
      instance_double(
        Order,
        email: "alphonso@example.com",
        id: 1,
        total_price: Money.new(price)
      )
    end

    let(:message) { instance_double(ActionMailer::MessageDelivery, deliver_now: nil) }
    let(:price) { 395_00 }
    let(:stripe_token) { "test_stripe_token" }

    before do
      allow(ChargesCustomers).to receive(:charge)
        .with(order.email, stripe_token, price, order.id)
      allow(Mailer).to receive(:order_received).with(order).and_return message

      described_class.build(order, stripe_token)
    end

    it "charges the customer" do
      expect(ChargesCustomers).to have_received(:charge)
        .with(order.email, stripe_token, price, order.id)
    end

    it "delivers the message" do
      expect(message).to have_received :deliver_now
    end
  end
end
