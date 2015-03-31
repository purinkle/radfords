class HomePage
  include Capybara::DSL

  def go_to_basket
    click_link "Basket"
  end

  def visit
    super("/")
  end
end
