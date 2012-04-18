# -- coding: utf-8 --

class ApplicationDecorator < Draper::Base
  def display_as_pounds(value)
    h.number_to_currency(value, unit: '£')
  end
end
