require "rails_helper"

describe "deleting products" do
  it "deletes existing product" do
    product = create_product
    expect(Product.count).to eql(1)

    sign_in

    visit delete_product_url(product)

    VCR.use_cassette("aws", match_requests_on: [:host]) do
      click_button("Delete Product")
    end

    expect(page).to have_title("Products")
    expect(page).to have_content("Product was deleted.")
    expect(Product.count).to be_zero
  end

  context "when the product can't be found" do
    it "shows the 'Products' page" do
      expect(Product.count).to be_zero

      sign_in

      visit delete_product_url(1)

      expect(page).to have_title("Products")
      expect(page).to have_content("We couldn't find that product.")
    end
  end

  context "when the product is already destroyed" do
    it "shows the 'Products' page" do
      product = create_product
      sign_in

      visit delete_product_url(product)

      VCR.use_cassette("aws", match_requests_on: [:host]) do
        product.destroy
      end

      VCR.use_cassette("aws", match_requests_on: [:host]) do
        click_button("Delete Product")
      end

      expect(page).to have_title("Products")
      expect(page).to have_content("We couldn't find that product.")
    end
  end

  context "when the product is in someone's basket" do
    it "shows the 'Products' page" do
      product = create_product
      expect(Product.count).to eql(1)
      visit product_url(product)
      find("input[type=submit]").click

      sign_in

      visit delete_product_url(product)

      VCR.use_cassette("aws", match_requests_on: [:host]) do
        click_button("Delete Product")
      end

      expect(page).to have_title("Delete Product")
      expect(page).to have_content("Line Items present")
    end
  end
end
