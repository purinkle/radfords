Factory.define :user do |user|
  user.name                  'Robert Whittaker'
  user.email                 'purinkle@example.com'
  user.password              'foobar'
  user.password_confirmation 'foobar'
end

Factory.define :event do |event|
  event.name           'Macclesfield Farmers Market'
  event.takes_place_on '2 October 2011'
  event.location       'Town Hall, Macclesfield'
end