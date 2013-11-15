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
end
