require "spec_helper"

module Features
  describe "create order" do
    it "show order summary" do
      sign_in
      create_product
      create_basket

      page = NewOrderPage.new
      page.visit

      expect(page).to have_product
    end

    def create_basket
      page = ProductPage.new
      page.visit
      page.add_to_basket
    end

    def create_product
      FactoryGirl.create(:product)
    end

    def sign_in
      page = NewSessionPage.new
      page.visit
      page.sign_in
    end
  end
end
