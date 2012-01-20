class CreateANewProduct < Spinach::FeatureSteps
  feature 'Create a new product'

  Given 'I am logged in' do
    email = 'user@example.com'
    password = 'password'

    User.create({
      name: 'Example User',
      email: email,
      password: password,
      password_confirmation: password
    });

    visit signin_path

    fill_in 'session_email', with: email
    fill_in 'session_password', with: password

    click_button 'Sign in'
  end

  When 'I click the new product link' do
    click_link 'New product'
  end

  When 'I visit the Products page' do
    visit products_path
  end

  Then 'I am shown the new product page' do
    should have_selector('title', text: 'New product')
  end

  Then 'there is a link to create a new product' do
    should have_selector('a', text: 'New product')
  end
end
