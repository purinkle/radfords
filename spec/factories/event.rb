FactoryGirl.define do
  factory :event do
    name 'Macclesfield Farmers Market'
    takes_place_on Time.local(2013, 8, 25, 12)
    location 'Town Hall, Macclesfield'
  end
end
