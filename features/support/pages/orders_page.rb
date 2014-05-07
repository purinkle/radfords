class OrdersPage
  include Capybara::DSL

  def orders
    page.all('tbody tr')
  end

  def visit_page
    visit '/orders'
  end
end
