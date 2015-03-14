require "spec_helper"

module Features
  describe "create from product page" do
    let(:product) { Product.last }
    let(:user) { FactoryGirl.create(:user) }

    before { FactoryGirl.create(:product) }

    it "shows the line item in the basket" do
      visit signin_path

      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)

      click_button "Sign in"

      visit product_url(product)

      find("input[type=submit]").click

      expect(page).to have_content("1 ×")
    end
  end
end
