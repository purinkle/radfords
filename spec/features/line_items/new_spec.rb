require "rails_helper"

module Features
  describe "create from product page" do
    let(:product) { Product.last }

    before do
      create_product
      sign_in
    end

    it "shows the line item in the basket" do
      add_line_item

      expect(page).to have_content("1 ×")
    end

    context "when the line item is already in the basket" do
      before { add_line_item }

      it "increases the line item's quantity" do
        add_line_item
        expect(page).to have_content("2 ×")
      end
    end

    def add_line_item
      visit product_url(product)
      find("input[type=submit]").click
    end
  end
end
