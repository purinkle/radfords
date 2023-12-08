module RadfordsTestHelpers
  def create_product(options = {})
    VCR.use_cassette("aws", match_requests_on: [:host]) do
      create(:product, options)
    end
  end

  def sign_in
    user = FactoryBot.create(:user)
    page = SigninPage.new(user.email, user.password)

    page.visit
    page.sign_in
  end
end

module Features
  include RadfordsTestHelpers
end
