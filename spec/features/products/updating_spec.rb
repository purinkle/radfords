require "rails_helper"

describe "updating products" do
  let(:product) do
    VCR.use_cassette("aws", match_requests_on: [:host]) do
      create(:product)
    end
  end

  let(:attributes) { attributes_for(:product) }
  let(:updated_product) { attributes.merge(title: "Gooseberry Jam") }

  it "successfully products" do
    sign_in
    visit edit_product_url(product)

    VCR.use_cassette("aws", match_requests_on: [:host]) do
      fill_form_and_submit(:product, :edit, updated_product)
    end

    expect(page).to have_title(updated_product.fetch(:title))
    expect(page).to have_content(updated_product.fetch(:title))
    expect(page).to have_content(updated_product.fetch(:description))
  end
end
