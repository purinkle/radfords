require "rails_helper"

describe Mailer do
  describe ".order_received" do
    subject(:mail) { described_class.order_received(order) }

    let(:order) do
      instance_double(
        Order,
        address: "",
        created_at: Time.zone.now,
        email: email,
        id: id,
        line_items: [],
        name: "",
        total_price: Money.new(0)
      )
    end

    let(:denise) { "rob@purinkle.co.uk" }
    let(:email) { "alphonso.quigley@example.com" }
    let(:id) { 5 }
    let(:title) { "Order confirmation for order #{id}" }

    it "sends a mail from Denise" do
      expect(mail.from).to eql([denise])
    end

    it "sends a mail to the order email and Denise" do
      expect(mail.to).to eql([email, denise])
    end

    it "sends a mail with the correct subject" do
      expect(mail.subject).to eql(title)
    end
  end

  describe ".order_shipped" do
    subject(:mail) { described_class.order_shipped(order) }

    let(:order) do
      instance_double(
        Order,
        address: nil,
        email: email,
        id: id,
        line_items: [],
        name: nil
      )
    end

    let(:email) { "alphonso.quigley@example.com" }
    let(:id) { 5 }
    let(:title) { "Shipping confirmation for order #{id}" }

    it 'sends a mail from "noreply@example.com"' do
      expect(mail.from).to eql(["rob@purinkle.co.uk"])
    end

    it "sends a mail to the order email" do
      expect(mail.to).to eql([email])
    end

    it "sends a mail with the correct subject" do
      expect(mail.subject).to eql(title)
    end
  end
end
