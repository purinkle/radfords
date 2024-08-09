class FindBasket
  def self.call(options)
    Basket.where(options).first || EmptyBasket.new
  end
end
