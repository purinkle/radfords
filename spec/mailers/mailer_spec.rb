require 'spec_helper'

describe Mailer do
  describe '#order_received' do
    it 'renders the sender email' do
      order = double
      order.stub(:email).once.with(no_args) { 'test@example.com' }
      order.stub(:name).once.with(no_args) { 'Alphonso' }
      order.stub(:line_items).once.with(no_args) { [] }
      mail = Mailer.order_received(order)
      expect(mail.from).to eql ['noreply@example.com']
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
