require "rails_helper"

module Features
  describe "creating a supplier" do
    it "creates a new supplier" do
      sign_in
      visit new_supplier_url

      VCR.use_cassette("google maps") do
        fill_form(:supplier, attributes_for(:supplier))
        click_button("Create Supplier")
      end

      expect(page).to have_text(name)
    end

    def name
      attributes_for(:supplier)[:name]
    end
  end
end
