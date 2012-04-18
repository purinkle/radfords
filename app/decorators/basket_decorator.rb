class BasketDecorator < ApplicationDecorator
  decorates :basket

  def line_items
    LineItemDecorator.decorate(model.line_items)
  end

  def total_price
    display_as_pounds(model.total_price)
  end
end
