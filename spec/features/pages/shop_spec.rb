require "rails_helper"

describe "shop page" do
  it "lists products" do
    product = create(:product)

    visit shop_url

    expect(page).to have_title("Shop")
    expect(page).to have_content(product.title)
  end
end
