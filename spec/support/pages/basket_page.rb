class BasketPage
  include Capybara::DSL

  def decrease_item_quantity
    first(:button, "-").click
  end

  def has_items_in_created_at_order?
    body.index(first_product.title) < body.index(last_product.title)
  end

  def increase_item_quantity
    first(:button, "+").click
  end

  def visit
    super "/basket"
  end

  private

  def first_product
    Product.first
  end

  def last_product
    Product.last
  end
end
