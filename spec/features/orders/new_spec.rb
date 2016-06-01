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
      expect(page).to have_content("Thank you")
      expect(page).to have_content("Your order was placed successfully")
      expect(page).to have_content("You've just purchased this")

      order.line_items.each do |item|
        expect(page).to have_content("#{item.quantity}× #{item.product.title}")
      end

      expect(page).to have_content("Your Order ID is: #{order.id}")
      expect(page).to have_content(
        <<-TEXT
        An email receipt containing information about your order will soon
        follow. Please keep it for your records.
        TEXT
      )
      expect(page).to have_content(
        "Thank you for shopping at Radfords of Somerford"
      )
    end

    def create_basket
      page = ProductPage.new
      page.visit
      page.add_to_basket
    end
  end
end
