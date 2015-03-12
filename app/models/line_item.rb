class LineItem < ActiveRecord::Base
  belongs_to :basket
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }

  def total_price
    product.price * quantity
  end
end
