class FindBasket
  def self.call(options)
    Basket.with_line_items.where(options).first || EmptyBasket.new
  end
end
