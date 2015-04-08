class HomePage
  include Capybara::DSL

  def go_to_basket
    click_link "Basket (0)"
  end

  def visit
    super("/")
  end
end
