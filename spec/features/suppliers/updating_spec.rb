require "rails_helper"

describe "updating suppliers" do
  it "successfully updates" do
    supplier = VCR.use_cassette("google maps") do
      FactoryBot.create(:supplier)
    end

    sign_in
    visit edit_supplier_url(supplier)

    VCR.use_cassette("google maps") do
      fill_form_and_submit(:supplier, :edit, attributes_for(:supplier))
    end

    expect(page).to have_title("Outlets")
    expect(page).to have_text(supplier.address)
    expect(page).to have_text(supplier.name)
    expect(page).to have_text(supplier.telephone_number)
    expect(page).to have_text(supplier.website)
  end

  context "when the attributes are invalid" do
    it "shows the 'Edit Supplier' page" do
      supplier = VCR.use_cassette("google maps") do
        FactoryBot.create(:supplier)
      end

      sign_in
      visit edit_supplier_url(supplier)

      VCR.use_cassette("google maps") do
        fill_form_and_submit(
          :supplier,
          :edit,
          address: "",
          name: "",
          telephone_number: ""
        )
      end

      expect(page).to have_title("Edit Supplier")
      expect(page).to have_text("errors prohibited this from being saved")
      expect(page).to have_text("Address can't be blank")
      expect(page).to have_text("Name can't be blank")
      expect(page).to have_text("Telephone number can't be blank")
    end
  end
end
