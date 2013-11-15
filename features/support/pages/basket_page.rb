class BasketPage
  include Capybara::DSL

  def checkout
    click_button 'Checkout'
  end

  def empty
    click_button('Empty basket')
  end

  def has_product_twice?
    has_css?('td', text: '2 ×')
  end

  def visit_page
    visit "/baskets/foo"
  end
end
