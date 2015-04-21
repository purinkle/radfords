class BasketDecorator
  def initialize(basket)
    @basket = basket
  end

  def self.model_name
    Basket.model_name
  end

  def item_count
    item_quantities.inject(0) { |quantity, acc| acc + quantity }
  end

  def line_items
    @basket.line_items.by_created_at
  end

  def to_partial_path
    all_partials.first
  end

  def total_price
    @basket.total_price
  end

  private

  def all_partials
    basket_partials.push(default_partial)
  end

  def basket_partials
    line_items.map { partial_path }
  end

  def default_partial
    "empty_basket"
  end

  def item_quantities
    line_items.map(&:quantity)
  end

  def partial_path
    @basket.to_partial_path
  end
end
