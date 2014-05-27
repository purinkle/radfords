require 'spec_helper'

describe Mailer do
  describe '.order_received' do
    subject { Mailer.order_received(order) }

    let(:order) do
      double(
        Order,
        address: '',
        created_at: Time.now,
        email: email,
        line_items: [],
        name: '',
        total_price: Money.new(0)
      )
    end

    let(:email) { 'alphonso.quigley@example.com' }
    let(:title) { 'Order confirmation for your order' }

    it 'sends a mail from Denise' do
      expect(subject.from).to eql(['denise@radfordsofsomerford.co.uk'])
    end

    it 'sends a mail to the order email' do
      expect(subject.to).to eql([email])
    end

    it 'sends a mail with the correct subject' do
      expect(subject.subject).to eql(title)
    end
  end

  describe '.order_shipped' do
    subject { Mailer.order_shipped(order) }

    let(:order) do
      double(Order, address: nil, email: email, line_items: [], name: nil)
    end

    let(:email) { 'alphonso.quigley@example.com' }
    let(:title) { 'Shipping confirmation for your order' }

    it 'sends a mail from "noreply@example.com"' do
      expect(subject.from).to eql(['denise@radfordsofsomerford.co.uk'])
    end

    it 'sends a mail to the order email' do
      expect(subject.to).to eql([email])
    end

    it 'sends a mail with the correct subject' do
      expect(subject.subject).to eql(title)
    end
  end
end
