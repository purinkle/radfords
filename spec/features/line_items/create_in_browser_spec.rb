require "rails_helper"

describe "creating line items in a browser", :js do
  it "shows the line item in the basket" do
    create_product

    add_product_to_basket

    expect(page).to have_text("1 ×")
    expect(page).to have_text(Product.first.title)
  end
end
