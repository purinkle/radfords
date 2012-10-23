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

Given /^I am on the edit product page$/ do
  visit edit_product_path(product)
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

When /^I create a product with valid data$/ do
  build_product
  new_product
end

When /^I go to the edit product page$/ do
  visit edit_product_path(product)
end

When /^I press "Cancel"$/ do
  click_link 'Cancel'
end

When /^I save a product with a duplicate title$/ do
  save_product(@product_2, title: @product_1.title)
end

When /^I save a product without a title$/ do
  save_product(@product, title: %Q{})
end

### THEN ###

Then /^I am redirected to the list of products$/ do
  should have_xpath('//title', text: @product.title)
end

Then /^I see a duplicate title message$/ do
  should have_content('Title has already been taken')
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

Then /^I see the edit product page$/ do
  should have_xpath('//title', text: 'Edit Product')
end

Then /^I see the index products page$/ do
  should have_xpath('//title', text: 'Products')
end

Then /^I see the product's photo$/ do
  should have_xpath("//img[contains(@src, \"#{@product.photo.url}\")]")
end

Then /^I see the show product page$/ do
  should have_xpath('//title', text: @product.title)
end

Then /^I see the sign in page$/ do
  should have_xpath('//title', text: 'Sign In')
end

Then /^the "Description" field contains the product's description$/ do
  expect(find_field('Description').value).to eql("\n#{@product.description}")
end

Then /^the "Title" field contains the product's title$/ do
  expect(find_field('Title').value).to eql(@product.title)
end
