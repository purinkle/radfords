require "rails_helper"

describe ChargesCustomers do
  describe ".charge" do
    subject(:result) do
      described_class.charge("payinguser@example.com", "tok_1041T92eZvKYlo2C223xGDdj", 50, 1)
    end

    let(:charge) { instance_double(Stripe::Charge) }
    # Stripe objects answer id through method_missing, so a verified double
    # cannot stand in for one. Build a real one from the API's JSON instead.
    let(:customer) { Stripe::Customer.construct_from(id: "cus_41cbOVn85eL5tY") }

    before do
      allow(Stripe::Charge).to receive(:create).with(
        customer: "cus_41cbOVn85eL5tY",
        amount: 50,
        description: "Payment for #1",
        currency: "gbp"
      ) { charge }
      allow(Stripe::Customer).to receive(:create).with(
        card: "tok_1041T92eZvKYlo2C223xGDdj",
        description: "Customer for #1",
        email: "payinguser@example.com"
      ) { customer }
    end

    it "returns the Stripe charge" do
      expect(result).to be(charge)
    end
  end
end
