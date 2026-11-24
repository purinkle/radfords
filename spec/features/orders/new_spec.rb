require "rails_helper"

module Features
  describe "create order" do
    it "show order summary" do
      expect(Order.count).to eql(0)

      create_product
      create_basket

      page = NewOrderPage.new
      page.visit

      fill_form(:order, :new, attributes_for(:order))

      VCR.use_cassette("stripe/customers") do
        VCR.use_cassette("stripe/charges") do
          click_button("Place my order")
        end
      end

      order = Order.last

      expect(Order.count).to eql(1)
      expect(page).to have_text("Thank you")
      expect(page).to have_text("Your order was placed successfully")
      expect(page).to have_text("You've just purchased this")

      order.line_items.each do |item|
        expect(page).to have_text("#{item.quantity}× #{item.product.title}")
      end

      expect(page).to have_text("Your Order ID is: #{order.id}")
      expect(page).to have_text <<~TEXT.squish
        An email receipt containing information about your order will soon
        follow. Please keep it for your records.
      TEXT
      expect(page).to have_text(
        "Thank you for shopping at Radfords of Somerford"
      )
    end

    context "when the order is invalid" do
      it "does not create an order" do
        expect(Order.count).to be_zero

        create_product
        create_basket

        page = NewOrderPage.new
        page.visit

        click_button("Place my order")

        expect(Order.count).to be_zero
        expect(page).to have_title("New order")
        expect(page).to have_text("errors prohibited this from being saved")
        expect(page).to have_text("Address city can't be blank")
        expect(page).to have_text("Address line 1 can't be blank")
        expect(page).to have_text("Address post code can't be blank")
        expect(page).to have_text("Name can't be blank")
        expect(page).to have_text("Email can't be blank")
      end
    end

    context "when the basket is empty" do
      it "shows the 'Shop' page" do
        expect(Order.count).to be_zero

        page = NewOrderPage.new
        page.visit

        expect(page).to have_title("Shop")
        expect(page).to have_text("Your basket is empty")
        expect(Order.count).to be_zero
      end
    end

    def create_basket
      page = ProductPage.new
      page.visit
      page.add_to_basket
    end
  end
end
