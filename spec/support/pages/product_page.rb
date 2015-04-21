class ProductPage
  include Capybara::DSL

  attr_reader :product

  def initialize(product: Product.first)
    @product = product
  end

  def add_to_basket
    click_button "Add to Basket"
  end

  def visit
    super "/products/#{product.id}"
  end
end
