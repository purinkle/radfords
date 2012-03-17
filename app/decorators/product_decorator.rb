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
    h.number_to_currency(model.price, unit: '£')
  end
end
