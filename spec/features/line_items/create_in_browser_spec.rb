require "rails_helper"

describe "creating line items in a browser", js: true do
  it "shows the line item in the basket" do
    create_product

    add_product_to_basket

    expect(page).to have_content("1 ×")
    expect(page).to have_content(Product.first.title)
  end
end
