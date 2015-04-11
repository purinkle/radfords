class NewSessionPage
  include Capybara::DSL

  def sign_in
    fill_in("Email", with: email)
    fill_in("Password", with: password)

    click_button "Sign in"
  end

  def visit
    super "/signin"
  end

  private

  def email
    user.email
  end

  def password
    user.password
  end

  def user
    @user ||= FactoryGirl.create(:user)
  end
end
