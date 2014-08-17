require 'spec_helper'

describe Order do
  let(:order) do
    Order.new(
      address: address,
      address_line_1: address_line_1,
      address_line_2: address_line_2,
      address_city: address_city,
      address_post_code: address_post_code,
      address_county: address_county,
      email: email,
      name: name
    )
  end

  let(:joined_address) do
    [
      "G G Batchelor & Son Ltd",
      "48 Lower Hillmorton Road",
      "Rugby",
      "CV21 3TE",
      "Warwickshire"
    ].join("\n")
  end

  let(:address) { nil }
  let(:address_city) { nil }
  let(:address_county) { nil }
  let(:address_line_1) { nil }
  let(:address_line_2) { nil }
  let(:address_post_code) { nil }
  let(:email) { "alphonso.quiqley@example.com" }
  let(:name) { "Alphonso Quigley" }

  describe '#add_line_items_from_basket' do
    let(:basket) { double("Basket", line_items: [item]) }
    let(:item) { double("LineItem") }

    before do
      allow(order).to receive(:line_items).and_return([])
    end

    it "clears the item's basket ID" do
      expect(item).to receive(:basket_id=).with(nil)
      order.add_line_items_from_basket(basket)
    end
  end

  describe "#address_line_1" do
    subject { order.address_line_1 }

    let(:address) { joined_address }
    let(:address_line_1) { "1 Bro Deg" }

    it "returns the first item in the address" do
      expect(subject).to eql("G G Batchelor & Son Ltd")
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns address line 1" do
        expect(subject).to eql address_line_1
      end
    end
  end

  describe "#address_line_2" do
    subject { order.address_line_2 }

    let(:address) { joined_address }
    let(:address_line_2) { "Pencoed" }

    it "returns the second item in the address" do
      expect(subject).to eql("48 Lower Hillmorton Road")
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns address line 2" do
        expect(subject).to eql address_line_2
      end
    end
  end

  describe "#address_city" do
    subject { order.address_city }

    let(:address) { joined_address }
    let(:address_city) { "Bridgend" }

    it "returns the third item in the address" do
      expect(subject).to eql "Rugby"
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns the city" do
        expect(subject).to eql address_city
      end
    end
  end

  describe "#address_post_code" do
    subject { order.address_post_code }

    let(:address) { joined_address }
    let(:address_post_code) { "CF35 6YS" }

    it "returns the fourth item in the address" do
      expect(subject).to eql "CV21 3TE"
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns the post code" do
        expect(subject).to eql address_post_code
      end
    end
  end

  describe "#address_county" do
    subject { order.address_county }

    let(:address) { joined_address }
    let(:address_county) { "Glamorgan" }

    it "returns the fifth item in the address" do
      expect(subject).to eql "Warwickshire"
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns the county" do
        expect(subject).to eql address_county
      end
    end
  end

  describe "#make_address" do
    let(:address_line_1) { "1 Bro Deg" }
    let(:made_address) { [address_line_1].join("\n") }

    before do
      order.make_address
    end

    it "sets the address" do
      expect(order.address).to eql made_address
    end
  end

  describe '#total_price' do
    subject { order.total_price }

    let(:item_1) { double(LineItem, total_price: Money.new(395)) }
    let(:item_2) { double(LineItem, total_price: Money.new(1485)) }

    before do
      allow(order).to receive(:line_items).and_return([item_1, item_2])
    end

    it "returns the sum of each line item's total price" do
      expect(subject).to eql(Money.new(1880))
    end
  end
end
