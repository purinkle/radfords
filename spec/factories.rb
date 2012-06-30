FactoryGirl.define do
  factory :user do
    name 'Robert Whittaker'
    email 'purinkle@example.com'
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :event do
    name 'Macclesfield Farmers Market'
    takes_place_on 1.week.from_now
    location 'Town Hall, Macclesfield'
  end

  factory :supplier do
    address '4 Buckingham Road, Thorpe Larches TS21 6FF'
    name 'Jack Green'
    telephone_number '07735 522248'
    website 'http://soldierresources.com/'
  end
end