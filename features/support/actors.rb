module Actors
  include Spinach::DSL

  Given 'I am an administrator' do
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

  Given 'I am a customer' do
  end
end
