class NewOrderPage
  include Capybara::DSL

  def has_product?
    has_content? "#{title} × 1"
  end

  def visit
    super "/orders/new"
  end

  private

  def product
    Product.last
  end

  def title
    product.title
  end
end
