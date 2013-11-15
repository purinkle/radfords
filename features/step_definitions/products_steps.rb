### GIVEN ###

Given(/^I am deleting the product$/) do
  product = Product.last
  delete_product_page = DeleteProductPage.new
  delete_product_page.visit_page(product)
end

Given(/^someone else deletes the product$/) do
  product = Product.last

  VCR.use_cassette('delete product', match_requests_on: [:host]) do
    product.destroy
  end

  expect(Product.all).to have(0).products
end

### WHEN ###

When(/^I create an invalid product$/) do
  new_product_page = NewProductPage.new

  visit new_product_path

  new_product_page.create
end

When(/^I delete the product$/) do
  delete_product_page = DeleteProductPage.new
  delete_product_page.delete
end

### THEN ###

Then(/^I see a "Line Items present" error$/) do
  delete_product_page = DeleteProductPage.new
  expect(delete_product_page).to have_line_item_error
end
