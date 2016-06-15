require "rails_helper"

describe "creating suppliers" do
  it "creates suppliers" do
    supplier = attributes_for(:supplier)
    sign_in
    visit new_supplier_url

    VCR.use_cassette("google maps") do
      fill_form_and_submit(:supplier, :new, supplier)
    end

    expect(page).to have_title("Outlets")
    expect(page).to have_content("You successfully created a supplier.")
    expect(page).to have_content(supplier.fetch(:address))
    expect(page).to have_content(supplier.fetch(:name))
    expect(page).to have_content(supplier.fetch(:telephone_number))
    expect(page).to have_content(supplier.fetch(:website))
  end

  context "when the supplier is invalid" do
    it "redirects back to the new supplier page" do
      sign_in
      visit new_supplier_url

      click_on submit(:supplier, :create)

      expect(page).to have_title("New Supplier")
      expect(page).to have_content("errors prohibited this from being saved")
      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Telephone number can't be blank")
    end
  end
end
