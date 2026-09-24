class NewOrderPage
  include Capybara::DSL

  # A number that passes Luhn, an expiry the clock cannot overtake and a three
  # digit code. The checkout JavaScript asks Stripe for a token only when all
  # three hold.
  def fill_in_card_details
    fill_in_card("4242424242424242", "12", next_year, "123")
  end

  # Wrong in each of the three ways the checkout JavaScript looks for.
  def fill_in_unusable_card_details
    fill_in_card("4242424242424241", "13", last_year, "1")
  end

  def has_product?
    has_content? "#{title} × 1"
  end

  def visit
    super "/orders/new"
  end

  private

  def fill_in_card(number, expiry_month, expiry_year, cvc)
    find(".card-number").set(number)
    find(".card-expiry-month").set(expiry_month)
    find(".card-expiry-year").set(expiry_year)
    find(".card-cvc").set(cvc)
  end

  def last_year
    (Date.current.year - 1).to_s
  end

  def next_year
    (Date.current.year + 1).to_s
  end

  def product
    Product.last
  end

  def title
    product.title
  end
end
