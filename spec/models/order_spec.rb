require "rails_helper"

describe Order do
  let(:order) do
    described_class.new(
      address: address,
      email: "alphonso.quiqley@example.com",
      name: "Alphonso Quigley",
      **line_attributes
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
  let(:line_attributes) { {} }

  describe "#address_line_1" do
    subject(:line) { order.address_line_1 }

    let(:address) { joined_address }
    let(:line_attributes) { { address_line_1: "1 Bro Deg" } }

    it "returns the first item in the address" do
      expect(line).to eql("G G Batchelor & Son Ltd")
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns address line 1" do
        expect(line).to eql("1 Bro Deg")
      end
    end
  end

  describe "#address_line_2" do
    subject(:line) { order.address_line_2 }

    let(:address) { joined_address }
    let(:line_attributes) { { address_line_2: "Pencoed" } }

    it "returns the second item in the address" do
      expect(line).to eql("48 Lower Hillmorton Road")
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns address line 2" do
        expect(line).to eql("Pencoed")
      end
    end
  end

  describe "#address_city" do
    subject(:line) { order.address_city }

    let(:address) { joined_address }
    let(:line_attributes) { { address_city: "Bridgend" } }

    it "returns the third item in the address" do
      expect(line).to eql("Rugby")
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns the city" do
        expect(line).to eql("Bridgend")
      end
    end
  end

  describe "#address_post_code" do
    subject(:line) { order.address_post_code }

    let(:address) { joined_address }
    let(:line_attributes) { { address_post_code: "CF35 6YS" } }

    it "returns the fourth item in the address" do
      expect(line).to eql("CV21 3TE")
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns the post code" do
        expect(line).to eql("CF35 6YS")
      end
    end
  end

  describe "#address_county" do
    subject(:line) { order.address_county }

    let(:address) { joined_address }
    let(:line_attributes) { { address_county: "Glamorgan" } }

    it "returns the fifth item in the address" do
      expect(line).to eql("Warwickshire")
    end

    context "when the address is not set" do
      let(:address) { nil }

      it "returns the county" do
        expect(line).to eql("Glamorgan")
      end
    end
  end

  describe "#basket" do
    it "is the basket associated with the order" do
      basket = build(:basket)
      order = create(:order, basket: basket)

      expect(order.basket).to be basket
    end

    context "when the order is missing a basket" do
      it "is an empty basket" do
        order = create(:order, basket: nil)

        expect(order.basket).to have_attributes(line_items: [])
      end
    end
  end

  describe "#line_items" do
    let(:items) { [] }

    before do
      allow(order).to receive(:basket)
        .and_return(instance_double(Basket, line_items: items))
    end

    it "returns the basket's line items" do
      expect(order.line_items).to be(items)
    end
  end

  describe "#make_address" do
    let(:line_attributes) { { address_line_1: "1 Bro Deg" } }

    before do
      order.make_address
    end

    it "sets the address" do
      expect(order.address).to eql "1 Bro Deg"
    end
  end

  describe "#total_price" do
    subject(:total_price) { order.total_price }

    let(:line_items) do
      [
        instance_double(LineItem, total_price: Money.new(395)),
        instance_double(LineItem, total_price: Money.new(1485))
      ]
    end

    before do
      allow(order).to receive(:line_items).and_return(line_items)
    end

    it "returns the sum of each line item's total price" do
      expect(total_price).to eql(Money.new(1880))
    end
  end
end
