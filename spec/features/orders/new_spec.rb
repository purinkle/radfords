require "rails_helper"

module Features
  describe "create order", :aggregate_failures do
    it "shows the order form for the basket" do
      product = create_product
      add_product_to_basket

      page = NewOrderPage.new
      page.visit

      expect(page).to have_title("New order")
      expect(page).to have_text(product.title)
      expect(page).to have_button("Place my order")
    end

    context "when the basket is empty" do
      it "shows the 'Shop' page" do
        expect(Order.count).to be_zero

        product = create_product

        page = NewOrderPage.new
        page.visit

        expect(page).to have_title("Shop")
        expect(page).to have_text("Your basket is empty")
        expect(page).to have_text(product.title)
        expect(Order.count).to be_zero
      end
    end
  end
end
