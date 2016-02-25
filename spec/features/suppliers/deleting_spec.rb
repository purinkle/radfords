require "rails_helper"

module Features
  describe "deleting orders" do
    it "deletes existing order" do
      VCR.use_cassette("google maps") do
        FactoryGirl.create(:supplier)
      end

      sign_in
      visit outlets_url

      click_button("Delete")

      expect(page).to have_title("Outlets")
      expect(page).to have_text("You successfully deleted the supplier.")
    end
  end
end
