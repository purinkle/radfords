require "spec_helper"

module Features
  describe "edit line item" do
    it "increases the item's quantity" do
      create :product
      sign_in
      add_products_to_basket

      basket_page.visit
      basket_page.increase_item_quantity

      expect(basket_page).to have_content("2 ×")
    end

    it "decreases the item's quantity" do
      create :product
      sign_in
      add_products_to_basket

      basket_page.visit
      basket_page.increase_item_quantity
      basket_page.decrease_item_quantity

      expect(basket_page).to have_content("1 ×")
    end

    it "only allows positive quantities" do
      create :product
      sign_in
      add_products_to_basket

      basket_page.visit
      basket_page.decrease_item_quantity

      expect(basket_page).to have_content("1 ×")
    end

    it "keeps the items in the correct order" do
      create_products
      sign_in
      add_products_to_basket

      basket_page.visit
      basket_page.increase_item_quantity

      expect(basket_page).to have_items_in_created_at_order
    end

    def add_products_to_basket
      Product.all.each do |product|
        page = ProductPage.new(product: product)
        page.visit
        page.add_to_basket
      end
    end

    def basket_page
      @basket_page ||= BasketPage.new
    end

    def create_products
      create(:product, title: "Plum Jam")
      create(:product, title: "Rhubarb and Ginger Jam")
    end

    def sign_in
      page = NewSessionPage.new
      page.visit
      page.sign_in
    end
  end
end
