require 'factory_girl'

FactoryGirl.define do
  factory :line_item do
  end

  factory :order do
  end

  factory :product do
    image_url 'image.jpg'
    price 2.85
  end
end