require "rails_helper"

module Features
  describe "creating products" do
    it "creates products" do
      sign_in
      visit new_product_url

      VCR.use_cassette("aws", match_requests_on: [:host]) do
        fill_form(:product, attributes_for(:product, title: product_name))
        click_on(submit(:product))
      end

      expect(page).to have_title(product_name)
      expect(page).to have_text("You successfully created a product")
    end

    def product_name
      "Raspberry Jam"
    end
  end
end
