include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :basket do
  end

  factory :event do
    name "Macclesfield Farmers Market"
    takes_place_on { Time.current + 1.day }
    location "Town Hall, Macclesfield"
  end

  factory :line_item do
    basket
    product { build(:product, price: price) }

    transient do
      price { Money.new(5_00) }
    end
  end

  factory :user do
    name 'Robert Whittaker'
    email 'purinkle@example.com'
    password 'foobar'
    password_confirmation { password }
  end

  factory :supplier do
    address '4 Buckingham Road, Thorpe Larches TS21 6FF'
    name 'Jack Green'
    telephone_number '07735 522248'
    website 'http://soldierresources.com/'
  end

  factory :product do
    description 'Packed full of bar, baz, and plenty of qux.'
    photo { File.open("spec/support/files/photo.jpg") }
    title 'foo'
  end
end
