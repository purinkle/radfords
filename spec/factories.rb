include ActionDispatch::TestProcess

FactoryBot.define do
  factory :basket do
  end

  factory :event do
    name "Macclesfield Farmers Market"
    takes_place_on { Time.current + 1.day }
    location "Town Hall, Macclesfield"
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
    title 'foo'

    # Attached rather than set as an attribute, so that attributes_for stays a
    # hash of plain values that Formulaic can fill a form with.
    after(:build) do |product|
      product.photo.attach(
        io: File.open(PhotoFixture::PATH),
        filename: PhotoFixture::FILENAME,
        content_type: PhotoFixture::CONTENT_TYPE,
      )
    end
  end
end
