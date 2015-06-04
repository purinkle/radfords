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
        id: id,
        line_items: [],
        name: '',
        total_price: Money.new(0)
      )
    end

    let(:denise) { "denise@radfordsofsomerford.co.uk" }
    let(:email) { 'alphonso.quigley@example.com' }
    let(:id) { 5 }
    let(:title) { "Order confirmation for order #{id}" }

    it 'sends a mail from Denise' do
      expect(subject.from).to eql([denise])
    end

    it "sends a mail to the order email and Denise" do
      expect(subject.to).to eql([email, denise])
    end

    it 'sends a mail with the correct subject' do
      expect(subject.subject).to eql(title)
    end
  end

  describe '.order_shipped' do
    subject { Mailer.order_shipped(order) }

    let(:order) do
      double(
        Order,
        address: nil,
        email: email,
        id: id,
        line_items: [],
        name: nil
      )
    end

    let(:email) { 'alphonso.quigley@example.com' }
    let(:id) { 5 }
    let(:title) { "Shipping confirmation for order #{id}" }

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
