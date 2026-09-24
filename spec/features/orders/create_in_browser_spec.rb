require "rails_helper"

module Features
  describe "creating orders in a browser", js: true do
    let(:order_page) { NewOrderPage.new }

    before do
      create_product
      add_product_to_basket

      order_page.visit
      fill_form(:order, :new, attributes_for(:order))
    end

    it "pays for the basket through the checkout JavaScript" do
      order_page.fill_in_card_details

      # The click returns before the server has charged the card, so the
      # cassettes have to stay in place until the confirmation arrives.
      VCR.use_cassette("stripe/customers") do
        VCR.use_cassette("stripe/charges") do
          click_button("Place my order")

          expect(page).to have_content("Thank you")
          expect(page).to have_content("Your order was placed successfully")
        end
      end

      expect(Order.count).to eql(1)
      expect(page).to have_content("Your Order ID is: #{Order.last.id}")

      # Only the checkout JavaScript can put a token on the form. Without it
      # the form would post straight to the server with no card at all.
      expect(WebMock).to have_requested(
        :post,
        "https://api.stripe.com/v1/customers",
      ).with(body: hash_including("card" => "tok_test_stub"))
    end

    it "refuses a card the browser can see is wrong" do
      order_page.fill_in_unusable_card_details

      click_button("Place my order")

      expect(page).to have_content("This card number looks invalid")
      expect(page).to have_content("Your card's expiration date is invalid")
      expect(page).to have_content("Your card's security code is invalid")
      expect(Order.count).to be_zero
    end
  end
end
