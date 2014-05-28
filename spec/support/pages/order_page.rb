class OrderPage
  include Capybara::DSL

  def initialize(order)
    @order = order
  end

  def fulfil
    click_button('Fulfil')
  end

  def has_address?
    page.has_content?(order.address)
  end

  def has_email?
    page.has_content?(order.email)
  end

  def has_name?
    page.has_content?(order.name)
  end

  def visit_page
    visit "/orders/#{order.id}"
  end

  private

  attr_reader :order
end
