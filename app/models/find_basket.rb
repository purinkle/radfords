class FindBasket
  def self.call(options)
    Basket.where(options).first || MissingBasket.new
  end
end
