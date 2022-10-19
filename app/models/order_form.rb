class OrderForm
  include ActiveModel::Model

  attr_accessor(
    :address_city,
    :address_county,
    :address_line_1,
    :address_post_code,
    :basket,
    :card_cvc,
    :card_exp_month,
    :card_exp_year,
    :card_number,
    :email,
    :name,
  )

  validates :address_city, presence: true
  validates :address_line_1, presence: true
  validates :address_post_code, presence: true
  validates :name, presence: true
  validates :email, presence: true

  def self.model_name
    ActiveModel::Name.new(self, nil, "Order")
  end

  def id
    if @order.present?
      @order.id
    end
  end

  def save
    if valid?
      OrderBuilder.build(create_order, create_card)
      true
    else
      false
    end
  end

  private

  def create_order
    @order = Order.create(
      address_city: address_city,
      address_post_code: address_post_code,
      basket: basket,
      email: email,
      name: name,
    )
  end

  def create_card
    Stripe::Token.create(
      card: {
        number: card_number,
        exp_month: card_exp_month,
        exp_year: card_exp_year,
        cvc: card_cvc,
      },
    )
  end
end
