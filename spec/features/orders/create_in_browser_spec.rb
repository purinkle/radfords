require "rails_helper"

module Features
  describe "creating orders in a browser", :aggregate_failures, :js do
    let(:order_page) { NewOrderPage.new }

    it "refuses an unusable card, then pays through the checkout JavaScript" do
      start_checkout
      order_page.fill_in_unusable_card_details
      click_button("Place my order")
      expect_card_refused

      order_page.fill_in_card_details
      place_order
      expect_order_confirmed
    end

    def start_checkout
      create_product
      add_product_to_basket
      order_page.visit
      fill_form(:order, :new, attributes_for(:order))
    end

    def expect_card_refused
      expect(page).to have_text("This card number looks invalid")
      expect(page).to have_text("Your card's expiration date is invalid")
      expect(page).to have_text("Your card's security code is invalid")
      expect(Order.count).to be_zero
    end

    # The click returns before the server has charged the card, so the
    # cassettes have to stay in place until the confirmation arrives.
    def place_order
      VCR.use_cassette("stripe/customers") do
        VCR.use_cassette("stripe/charges") do
          click_button("Place my order")

          expect(page).to have_text("Thank you")
          expect(page).to have_text("Your order was placed successfully")
        end
      end
    end

    def expect_order_confirmed
      expect(Order.count).to be(1)
      order = Order.with_line_items.last
      expect_order_summary(order)
      expect(page).to have_text("Your Order ID is: #{order.id}")
      expect_receipt_promised
      expect_token_sent_to_stripe
    end

    def expect_receipt_promised
      expect(page).to have_text <<~TEXT.squish
        An email receipt containing information about your order will soon
        follow. Please keep it for your records.
      TEXT
      expect(page).to have_text("Thank you for shopping at Radfords of Somerford")
    end

    def expect_order_summary(order)
      expect(page).to have_text("You've just purchased this")
      order.line_items.each do |item|
        expect(page).to have_text("#{item.quantity}× #{item.product.title}")
      end
    end

    # Only the checkout JavaScript can put a token on the form. Without it
    # the form would post straight to the server with no card at all.
    def expect_token_sent_to_stripe
      expect(WebMock).to have_requested(:post, "https://api.stripe.com/v1/customers")
        .with(body: hash_including("card" => "tok_test_stub"))
    end
  end
end
