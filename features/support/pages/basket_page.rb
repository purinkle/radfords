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
    visit "/basket"
  end

  def view_product
    click_link product.title
  end

  private

  def product
    Product.last
  end
end
