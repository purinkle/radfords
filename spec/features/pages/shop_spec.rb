require "rails_helper"

describe "shop page" do
  it "lists products" do
    product = VCR.use_cassette("aws", match_requests_on: [:host]) do
      create(:product)
    end

    visit shop_url

    expect(page).to have_title("Shop")
    expect(page).to have_content(product.title)
  end
end
