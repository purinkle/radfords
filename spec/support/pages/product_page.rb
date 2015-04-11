class ProductPage
  include Capybara::DSL

  def add_to_basket
    click_button "Add to Basket"
  end

  def visit
    super "/products/#{product.id}"
  end

  private

  def product
    Product.last
  end
end
