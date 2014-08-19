class Order < ActiveRecord::Base
  has_one :basket, dependent: :destroy

  validates(
    :address_city,
    :address_line_1,
    :address_post_code,
    :name,
    :email,
    presence: true
  )
  validates :viewed, inclusion: [false, true]

  before_validation :make_address

  attr_writer(
    :address_city,
    :address_county,
    :address_line_1,
    :address_line_2,
    :address_post_code
  )

  scope :by_created_at, -> { order('created_at desc') }

  def address_line_1
    split_address.fetch(0, @address_line_1)
  end

  def address_line_2
    split_address.fetch(1, @address_line_2)
  end

  def address_city
    split_address.fetch(2, @address_city)
  end

  def address_post_code
    split_address.fetch(3, @address_post_code)
  end

  def address_county
    split_address.fetch(4, @address_county)
  end

  def line_items
    basket.line_items
  end

  def make_address
    self.address = address_parts.join("\n")
  end

  def total_price
    line_items.inject(Money.new(0)) { |total, item| total + item.total_price }
  end

  private

  def address_parts
    [
      address_line_1,
      address_line_2,
      address_city,
      address_post_code,
      address_county
    ].compact
  end

  def split_address
    (address || "").split("\n")
  end
end
