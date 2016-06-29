class BasketDecorator
  def initialize(basket)
    @basket = basket
  end

  def item_count
    item_quantities.inject(0) { |quantity, acc| acc + quantity }
  end

  def line_items
    @basket.line_items.by_created_at
  end

  def to_model
    @basket
  end

  def total_price
    @basket.total_price
  end

  private

  def item_quantities
    line_items.map(&:quantity)
  end
end
