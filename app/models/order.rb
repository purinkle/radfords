class Order < ActiveRecord::Base
  has_many(:line_items, dependent: :destroy)

  validates :name, :address, presence: true

  def add_line_items_from_basket(basket)
    basket.line_items.each do |item|
      item.basket_id = nil
      line_items << item
    end
  end
end
