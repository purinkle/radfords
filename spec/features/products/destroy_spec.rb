require "rails_helper"

describe "deleting products" do
  it "deletes existing product" do
    product = create_product
    expect(Product.count).to eql(1)

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
      expect(Product.count).to eql(1)
      visit product_url(product)
      find("input[type=submit]").click

      sign_in

      visit delete_product_url(product)

      click_button("Delete Product")

      expect(page).to have_title("Delete Product")
      expect(page).to have_text("Line Items present")
    end
  end
end
