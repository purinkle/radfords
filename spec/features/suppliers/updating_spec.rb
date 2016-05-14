require "rails_helper"

describe "updating suppliers" do
  it "successfully updates" do
    supplier = VCR.use_cassette("google maps") do
      FactoryGirl.create(:supplier)
    end

    sign_in
    visit edit_supplier_url(supplier)

    VCR.use_cassette("google maps") do
      fill_form_and_submit(:supplier, :edit, attributes_for(:supplier))
    end

    expect(page).to have_title("Outlets")
    expect(page).to have_content(supplier.address)
    expect(page).to have_content(supplier.name)
    expect(page).to have_content(supplier.telephone_number)
    expect(page).to have_content(supplier.website)
  end
end
