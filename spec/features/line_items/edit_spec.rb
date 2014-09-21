require "spec_helper"

module Features
  describe "destroy line item" do
    let(:user) { FactoryGirl.create :user }

    before { FactoryGirl.create :product }

    it "removes the line item from the basket" do
      visit signin_path

      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)

      click_button "Sign in"

      visit root_path

      find("input[type=submit]").click

      click_button "+"

      expect(page).to have_content("2 ×")
    end
  end
end
