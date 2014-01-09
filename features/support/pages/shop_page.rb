class ShopPage
  include Capybara::DSL

  def add_to_basket(product)
    click_button 'Add to Basket'
  end

  def visit_page
    visit '/shop'
  end
end
