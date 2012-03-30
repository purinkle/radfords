class IndexSuppliers < Spinach::FeatureSteps
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

  And 'some suppliers have been created' do
    Supplier.create({
      name: 'Foo',
      address: '1 Example Street',
      telephone_number: '01234 567890'
    })
    Supplier.create({
      name: 'Bar',
      address: '1 Example Street',
      telephone_number: '01234 567890'
    })
  end

  When 'I click the "Where to buy" link' do
    click_link('Where to buy')
  end

  Then 'each supplier is displayed' do
    %w(Foo Bar).each do |supplier|
      should have_selector('h3', text: supplier)
    end
  end

  Then 'a "Delete" button is displayed' do
    should have_selector('input[value="Delete"]')
  end

  When 'I click a "Delete" button' do
    within('.suppliers li:nth-of-type(1)') do
      click_button('Delete')
    end
  end

  Then 'I am redirected back to the "Outlets" page' do
    should have_selector('title', text: 'Outlets')
  end

  Then 'the supplier is no longer displayed' do
    should_not have_selector('h3', text: 'Foo')
  end

  Then 'a success flash is displayed' do
    should have_selector('div.flash.success')
  end
end
