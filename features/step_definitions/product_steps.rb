### UTILITY METHODS ###

def build_product
  @product = FactoryGirl.build(:product)
end

def create_product(product = {})
  VCR.use_cassette('create_product', match_requests_on: [:host]) do
    FactoryGirl.create(:product, product)
  end
end

def create_user
  create_visitor
  @user = FactoryGirl.create(:user, @visitor)
end

def create_visitor
  @visitor = {
    email: 'joe@example.com',
    name: 'Joe Example',
    password: 'secret',
    password_confirmation: 'secret',
  }
end

def new_product
  visit '/products/new'
  fill_in 'Title', with: @product.title
  fill_in 'Description', with: @product.description
  attach_file('Photo', File.expand_path('../../support/photo.jpg', __FILE__))

  VCR.use_cassette('create_product', match_requests_on: [:host]) do
    click_button 'Create Product'
  end
end

def product
  @product || 'foo'
end

def save_product(id, product)
  visit edit_product_path(id)
  fill_in('Title', with: product[:title])
  click_button 'Save'
end

def sign_in
  visit '/signin'
  fill_in 'Email', with: @visitor[:email]
  fill_in 'Password', with: @visitor[:password]
  click_button 'Sign in'
end

### GIVEN ###

Given /^a product exists$/ do
  @product = create_product
end

Given /^I am not signed in$/ do
  visit signout_path
end

Given /^I am on the delete product page$/ do
  visit delete_product_path(product)
end

Given /^I am on the edit product page$/ do
  visit edit_product_path(product)
end

Given /^I am on the index products page$/ do
  visit products_path
end

Given /^I am on the show product page$/ do
  visit product_path(product)
end

Given /^I am signed in$/ do
  create_user
  sign_in
end

Given /^no products exist$/ do
  Product.destroy_all
end

Given /^some products exist$/ do
  @product_1 = create_product(title: 'Foo')
  @product_2 = create_product(title: 'Bar')
end

### WHEN ###

When /^I click the "Delete Product" button$/ do
  VCR.use_cassette('delete_product', match_requests_on: [:host]) do
    click_button 'Delete Product'
  end
end

When /^I create a product with valid data$/ do
  build_product
  new_product
end

When /^I follow the "Back" link$/ do
  click_link 'Back'
end

When /^I follow the "Cancel" link$/ do
  click_link 'Cancel'
end

When /^I follow the "Delete" link$/ do
  click_link 'Delete'
end

When /^I follow the "Edit" link$/ do
  click_link 'Edit'
end

When /^I follow the product's link$/ do
  click_link @product.title
end

When /^I go to the delete product page$/ do
  visit delete_product_path(product)
end

When /^I go to the edit product page$/ do
  visit edit_product_path(product)
end

When /^I go to the index products page$/ do
  visit products_path
end

When /^I go to the show product page$/ do
  visit product_path(product)
end

When /^I press "Cancel"$/ do
  click_link 'Cancel'
end

When /^I save a product with a duplicate title$/ do
  save_product(@product_2, title: @product_1.title)
end

When /^I save a product with valid data$/ do
  save_product(@product, title: @product.title)
end

When /^I save a product without a title$/ do
  save_product(@product, title: %Q{})
end

### THEN ###

Then /^I don't see the product$/ do
  expect(page).to_not have_content('foo')
end

Then /^I don't see the product admin controls$/ do
  expect(page).to_not have_selector('.form-actions')
end

Then /^I am redirected to the list of products$/ do
  expect(title).to match(/#{@product.title}/)
end

Then /^I see a "product was deleted" message$/ do
  expect(page).to have_content('Product was deleted.')
end

Then /^I see a duplicate title message$/ do
  should have_content('Title has already been taken')
end

Then /^I see a no products message$/ do
  should have_content('There are currently no products')
end

Then /^I see a product saved message$/ do
  should have_content('Product saved.')
end

Then /^I see a successful product creation message$/ do
  should have_content('The product was created successfully')
end

Then /^I see a sign in message$/ do
  should have_content('Please sign in to access this page')
end

Then /^I see a title missing message$/ do
  should have_content("Title can't be blank")
end

Then /^I see an invalid product message$/ do
  should have_content("We couldn't find that product")
end

Then /^I see each product's description$/ do
  should have_content(@product_1.description)
  should have_content(@product_2.description)
end

Then /^I see each product's photo$/ do
  should have_xpath("//img[contains(@src, \"#{@product_1.photo.url}\")]")
  should have_xpath("//img[contains(@src, \"#{@product_2.photo.url}\")]")
end

Then /^I see each product's title$/ do
  should have_content(@product_1.title)
  should have_content(@product_2.title)
end

Then /^I see the delete product page$/ do
  expect(title).to match(/Delete Product/)
end

Then /^I see the edit product page$/ do
  expect(title).to match(/Edit Product/)
end

Then /^I see the index products page$/ do
  expect(title).to match(/Products/)
end

Then /^I see the product's description$/ do
  should have_content(product.description)
end

Then /^I see the product's photo$/ do
  should have_xpath("//img[contains(@src, \"#{@product.photo.url}\")]")
end

Then /^I see the product's title$/ do
  should have_css('body', text: product.title)
end

Then /^I see the show product page$/ do
  expect(title).to match(/#{@product.title}/)
end

Then /^I see the sign in page$/ do
  expect(title).to match(/Sign In/)
end

Then /^the "Description" field contains the product's description$/ do
  expect(find_field('Description').value).to eql(@product.description)
end

Then /^the "Title" field contains the product's title$/ do
  expect(find_field('Title').value).to eql(@product.title)
end
