require "rails_helper"

module Features
  describe "creating orders in a browser", :js do
    let(:order_page) { NewOrderPage.new }

    it "refuses an unusable card, then pays through the checkout JavaScript" do
      expect(Order.count).to be_zero

      create_product
      add_product_to_basket

      order_page.visit
      fill_form(:order, :new, attributes_for(:order))

      order_page.fill_in_unusable_card_details

      click_button("Place my order")

      expect(page).to have_text("This card number looks invalid")
      expect(page).to have_text("Your card's expiration date is invalid")
      expect(page).to have_text("Your card's security code is invalid")
      expect(Order.count).to be_zero

      order_page.fill_in_card_details

      # The click returns before the server has charged the card, so the
      # cassettes have to stay in place until the confirmation arrives.
      VCR.use_cassette("stripe/customers") do
        VCR.use_cassette("stripe/charges") do
          click_button("Place my order")

          expect(page).to have_text("Thank you")
          expect(page).to have_text("Your order was placed successfully")
        end
      end

      order = Order.last

      expect(Order.count).to eql(1)
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

      # Only the checkout JavaScript can put a token on the form. Without it
      # the form would post straight to the server with no card at all.
      expect(WebMock).to have_requested(
        :post,
        "https://api.stripe.com/v1/customers"
      ).with(body: hash_including("card" => "tok_test_stub"))
    end
  end
end
