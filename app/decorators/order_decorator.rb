class OrderDecorator < ApplicationDecorator
  decorates :order

  def line_items
    LineItemDecorator.decorate(model.line_items)
  end
end