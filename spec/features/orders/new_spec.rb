require "rails_helper"

module Features
  describe "create order" do
    it "show order summary" do
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
  end
end
