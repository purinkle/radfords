class CreateSupplier < Spinach::FeatureSteps
  Given 'I am logged in' do
    email = 'user@example.com'
    password = 'password'
    User.create({
      name: 'Example User',
      email: email,
      password: password,
      password_confirmation: password
    })
    visit(signin_path)
    fill_in('session_email', with: email)
    fill_in('session_password', with: password)
    click_button('Sign in')
  end

  And 'I click the "Where to buy" link' do
    click_link('Where to buy')
  end

  When 'I click the "New supplier" link' do
    click_link('New supplier')
  end

  Then 'an address field is displayed' do
    should have_selector('#supplier_address')
  end
end
