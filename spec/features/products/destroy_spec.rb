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
end
