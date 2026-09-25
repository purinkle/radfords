module RadfordsTestHelpers
  def add_product_to_basket
    product_page = ProductPage.new
    product_page.visit
    product_page.add_to_basket

    # Clicking hands back before the redirect to the basket has arrived. A
    # browser that leaves for another page too early loses the basket.
    expect(page).to have_title("Your Basket")
  end

  def create_product(options = {})
    create(:product, options)
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
