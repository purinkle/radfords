require "rails_helper"

describe "listing orders" do
  it "list orders in order of creation" do
    order_1 = create(:order, name: "Joe Bloggs")
    order_2 = create(:order)

    sign_in
    visit orders_url

    order_1_index = page.body.index(order_1.name.to_s)
    order_2_index = page.body.index(order_2.name.to_s)

    expect(order_2_index).to be < order_1_index
  end
end
