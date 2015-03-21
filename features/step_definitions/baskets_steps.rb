### GIVEN

Given(/^I am on the "Shop" page$/) do
  shop_page = ShopPage.new
  shop_page.visit_page
end

Given(/^I am viewing my basket$/) do
  visit(basket_url)
end

Given(/^I don't have a basket$/) do
  expect(Basket.all.count).to be_zero
end

### WHEN

When(/^I add the product to my basket$/) do
  product = Product.last
  shop_page = ShopPage.new
  shop_page.add_to_basket(product)
end

When(/^I empty my basket$/) do
  basket_page = BasketPage.new
  basket_page.empty
end

When(/^I remove the product from my basket$/) do
  click_link("Remove")
end

When(/^I view the basket$/) do
  basket_page = BasketPage.new
  basket_page.visit_page
end

### THEN ###

Then(/^I see the product in my basket twice$/) do
  basket_page = BasketPage.new
  expect(basket_page).to have_product_twice
end
