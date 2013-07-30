### WHEN ###

When(/^I create an invalid product$/) do
  new_product_page = NewProductPage.new

  visit new_product_path

  new_product_page.create
end
