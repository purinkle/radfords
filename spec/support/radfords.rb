module RadfordsTestHelpers
  def sign_in
    user = FactoryGirl.create(:user)
    page = SigninPage.new(user.email, user.password)

    page.visit
    page.sign_in
  end
end

module Features
  include RadfordsTestHelpers
end
