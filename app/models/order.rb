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

  # The form takes the address a line at a time, and the table stores it as
  # one string, a line each in this order. Each reader gives back its line of
  # the stored address, or what was assigned until make_address joins them.
  ADDRESS_LINES = %i[
    address_line_1
    address_line_2
    address_city
    address_post_code
    address_county
  ].freeze

  ADDRESS_LINES.each_with_index do |line, index|
    attribute line, :string
    define_method(line) { split_address.fetch(index) { super() } }
  end

  scope :by_created_at, -> { order("created_at desc") }

  def basket
    super || MissingBasket.new
  end

  delegate :line_items, to: :basket

  def make_address
    self.address = address_parts.join("\n")
  end

  def total_price
    line_items.inject(Money.new(0)) { |total, item| total + item.total_price }
  end

  private

  def address_parts
    ADDRESS_LINES.filter_map { |line| public_send(line) }
  end

  def split_address
    (address || "").split("\n")
  end
end
