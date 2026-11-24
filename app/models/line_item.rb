class LineItem < ApplicationRecord
  belongs_to :basket
  belongs_to :order, optional: true
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }

  # What a page needs to show a line item: its product and that product's
  # photo. Strict loading raises on anything not loaded up front.
  PRELOADS = { product: { photo_attachment: :blob } }.freeze

  def total_price
    product.price * quantity
  end
end
