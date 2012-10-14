### UTILITY METHODS ###

def build_product
  @product = FactoryGirl.build(:product)
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

def sign_in
  visit '/signin'
  fill_in 'Email', with: @visitor[:email]
  fill_in 'Password', with: @visitor[:password]
  click_button 'Sign in'
end

### GIVEN ###

Given /^I am not signed in$/ do
  visit signout_path
end

Given /^I am signed in$/ do
  create_user
  sign_in
end

### WHEN ###

When /^I create a product with valid data$/ do
  build_product
  new_product
end

When /^I edit a product$/ do
  visit edit_product_path('foo')
end

### THEN ###

Then /^I am redirected to the list of products$/ do
  page.should have_xpath('//title', text: @product.title)
end

Then /^I see a successful product creation message$/ do
  page.should have_content('The product was created successfully')
end

Then /^I see a sign in message$/ do
  page.should have_content('Please sign in to access this page')
end

Then /^I see the sign in page$/ do
  should have_xpath('//title', text: 'Sign In')
end
