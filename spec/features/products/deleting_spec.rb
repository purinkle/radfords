require "rails_helper"

describe "deleting products" do
  let(:product) { create(:product) }

  it "shows products" do
    sign_in

    VCR.use_cassette("aws", match_requests_on: [:host]) do
      visit delete_product_url(product)
    end

    expect(page).to have_title("Delete Product")
  end
end
