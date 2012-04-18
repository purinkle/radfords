# -- coding: utf-8 --

class ProductDecorator < ApplicationDecorator
  decorates :product

  def class_name(count)
    if (count + 1) % 3 == 0
      'last'
    end
  end

  def image
    h.image_tag(model.image_url)
  end

  def price
    display_as_pounds(model.price)
  end
end
