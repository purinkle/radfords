class LineItem < ActiveRecord::Base
  belongs_to :basket
  belongs_to :order
  belongs_to :product

  def total_price
    product.price * quantity
  end
end
