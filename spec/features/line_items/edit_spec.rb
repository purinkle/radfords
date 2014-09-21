require "spec_helper"

module Features
  describe "edit line item" do
    let(:user) { FactoryGirl.create :user }

    before { FactoryGirl.create :product }

    it "increases the item's quantity" do
      visit signin_path

      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)

      click_button "Sign in"

      visit root_path

      find("input[type=submit]").click

      click_button "+"

      expect(page).to have_content("2 ×")
    end

    it "decreases the item's quantity" do
      visit signin_path

      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)

      click_button "Sign in"

      visit root_path

      find("input[type=submit]").click

      click_button "+"
      click_button "-"

      expect(page).to have_content("1 ×")
    end
  end
end
