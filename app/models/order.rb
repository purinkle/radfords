class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  validates :name, :email, presence: true
  validates :viewed, inclusion: [false, true]

  attr_accessor(
    :address_city,
    :address_county,
    :address_line_1,
    :address_line_2,
    :address_post_code
  )

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
