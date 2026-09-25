require "rails_helper"

describe "updating products" do
  let(:attributes) { attributes_for(:product) }
  let(:updated_product) { attributes.merge(title: "Gooseberry Jam") }

  let(:product) { create(:product) }

  before { sign_in }

  it "successfully products" do
    visit edit_product_url(product)

    fill_form_and_submit(:product, :edit, updated_product)

    expect(page).to have_title(updated_product.fetch(:title))
    expect(page).to have_content(updated_product.fetch(:title))
    expect(page).to have_content(updated_product.fetch(:description))
  end

  context "when a product with the same name exists" do
    before { create(:product, updated_product) }

    it "shows the 'Edit Product' page" do
      visit edit_product_url(product)

      fill_form_and_submit(:product, :edit, updated_product)

      expect(page).to have_title(t("titles.products.edit"))
      expect(page).to have_content("1 error prohibited this from being saved")
      expect(page).to have_content("Title has already been taken")
    end
  end
end
