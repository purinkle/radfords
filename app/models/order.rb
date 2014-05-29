class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  validates :name, :address, :email, presence: true
  validates :viewed, inclusion: [false, true]

  scope :by_created_at, -> { order('created_at desc') }

  def add_line_items_from_basket(basket)
    basket.line_items.each do |item|
      item.basket_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.inject(Money.new(0)) { |total, item| total + item.total_price }
  end
end
