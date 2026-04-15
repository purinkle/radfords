require "rails_helper"

module Features
  describe "destroy line item" do
    let(:user) { FactoryBot.create :user }

    before { create_product }

    it "removes the line item from the basket" do
      visit signin_path

      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)

      click_button "Sign in"

      visit root_path

      click_button "Add to Basket"

      click_link "Remove"

      expect(page).to_not have_content("1 ×")
    end
  end
end
