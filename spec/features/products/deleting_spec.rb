require "rails_helper"

describe "deleting products" do
  let(:product) { create(:product) }

  it "shows products" do
    sign_in

    visit delete_product_url(product)

    expect(page).to have_title("Delete Product")
  end
end
