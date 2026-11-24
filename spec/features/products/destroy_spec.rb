require "rails_helper"

describe "deleting products", :aggregate_failures do
  it "deletes existing product" do
    product = create_product
    expect(Product.count).to be(1)

    sign_in

    visit delete_product_url(product)

    expect(page).to have_title("Delete Product")

    click_button("Delete Product")

    expect(page).to have_title("Products")
    expect(page).to have_text("Product was deleted.")
    expect(Product.count).to be_zero
  end

  context "when the product is in someone's basket" do
    it "shows the 'Products' page" do
      product = create_product
      expect(Product.count).to be(1)
      add_product_to_basket

      sign_in

      visit delete_product_url(product)

      click_button("Delete Product")

      expect(page).to have_title("Delete Product")
      expect(page).to have_text("Line Items present")
    end
  end
end
