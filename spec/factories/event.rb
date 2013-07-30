FactoryGirl.define do
  factory :event do
    name 'Macclesfield Farmers Market'
    takes_place_on 1.week.from_now
    location 'Town Hall, Macclesfield'
  end
end
