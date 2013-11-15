### GIVEN

Given(/^I have an empty basket$/) do
  # noop
end

Given(/^I have checked out my basket$/) do
  basket_page = BasketPage.new
  basket_page.checkout
end

Given(/^I have the product in my basket$/) do
  product = Product.last
  shop_page = ShopPage.new
  shop_page.visit_page
  shop_page.add_to_basket(product)
end

### WHEN

When(/^I checkout my basket$/) do
  basket_page = BasketPage.new
  basket_page.checkout
end

When(/^I create the order$/) do
  new_order_page = NewOrderPage.new
  new_order_page.create(
    name: 'Alphonso Quigley',
    address: '1 Test Street, Testerton TE5 7TE',
    email: 'alphonso.quigley@example.com'
  )
end

When(/^I create the order incorrectly$/) do
  new_order_page = NewOrderPage.new
  new_order_page.create
end

When(/^I visit the "New order" page$/) do
  new_order_page = NewOrderPage.new
  new_order_page.visit_page
end

### THEN ###

Then(/^I see some validation messages$/) do
  new_order_page = NewOrderPage.new
  expect(new_order_page).to have_validation_messages
end
