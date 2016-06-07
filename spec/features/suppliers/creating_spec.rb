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
end
