class LineItem < ActiveRecord::Base
  belongs_to :basket
  belongs_to :order
  belongs_to :product

  validates :basket, presence: true
  validates :product, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  scope :by_created_at, -> { order(:created_at) }

  def total_price
    product.price * quantity
  end
end
