class SigninPage
  include Capybara::DSL
  include Capybara::Node::Matchers
  include RSpec::Matchers

  def initialize(email = nil, password = nil)
    @email = email
    @password = password
  end

  def sign_in
    fill_in 'Email', with: email
    fill_in 'Password', with: password

    click_button 'Sign in'
  end

  def visit
    super("/signin")
  end

  private

  attr_reader :email, :password
end
