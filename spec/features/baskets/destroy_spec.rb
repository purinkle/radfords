require "rails_helper"

describe "deleting baskets" do
  before { create_product }

  it "deletes existing basket" do
    visit shop_path
    find("input[type=submit]").click

    click_button "Empty basket"

    expect(page).to have_title("Your Basket")
    expect(page).to have_content("Your basket is currently empty.")
    expect(Basket.count).to eql(0)
  end
end
