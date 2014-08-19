FactoryGirl.define do
  factory :basket do
  end

  factory :user do
    name 'Robert Whittaker'
    email 'purinkle@example.com'
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :supplier do
    address '4 Buckingham Road, Thorpe Larches TS21 6FF'
    name 'Jack Green'
    telephone_number '07735 522248'
    website 'http://soldierresources.com/'
  end

  factory :product do
    description 'Packed full of bar, baz, and plenty of qux.'
    photo_file_name { "photo.jpg" }
    photo_content_type { "image/jpg" }
    photo_file_size { 1024 }
    price { Money.new(599) }
    title 'foo'
  end
end
