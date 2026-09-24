require "rails_helper"

describe "destroying baskets in a browser", js: true do
  it "empties the basket once the confirmation is accepted" do
    create_product
    add_product_to_basket

    accept_confirm { click_button "Empty basket" }

    expect(page).to have_title("Your Basket")
    expect(page).to have_content("Your basket is currently empty.")
    expect(Basket.count).to eql(0)
  end
end
