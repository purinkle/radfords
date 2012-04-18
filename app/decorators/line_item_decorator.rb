# -- coding: utf-8 --

class LineItemDecorator < ApplicationDecorator
  decorates :line_item

  def total_price
    display_as_pounds(model.total_price)
  end
end
