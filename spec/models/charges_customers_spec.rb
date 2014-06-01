require 'spec_helper'

describe ChargesCustomers do
  let(:charger) { ChargesCustomers.new(email, card, amount, order_id) }

  let(:amount) { 50 }
  let(:card) { 'tok_1041T92eZvKYlo2C223xGDdj' }
  let(:charge) { double(Stripe::Charge) }
  let(:email) { 'payinguser@example.com' }
  let(:order_id) { 1 }

  describe '.charge' do
    subject { ChargesCustomers.charge(email, card, amount, order_id) }

    let(:charger) { double(ChargesCustomers, charge: charge) }

    before do
      ChargesCustomers.stub(:new).with(email, card, amount, order_id).
        and_return(charger)
    end

    it 'returns the Stripe charge' do
      expect(subject).to be(charge)
    end
  end

  describe '#charge' do
    subject { charger.charge }

    let(:customer) { double(Stripe::Customer, id: customer_id) }
    let(:customer_id) { 'cus_41cbOVn85eL5tY' }

    before do
      Stripe::Charge.stub(:create).with(
        customer: customer_id,
        amount: amount,
        description: "Payment for ##{order_id}",
        currency: 'gbp'
      ).and_return(charge)
      Stripe::Customer.stub(:create).with(email: email, card: card).
        and_return(customer)
    end

    it 'returns the Stripe charge' do
      expect(subject).to be(charge)
    end
  end
end
