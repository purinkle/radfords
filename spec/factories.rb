Factory.define :user do |user|
  user.name                  'Robert Whittaker'
  user.email                 'purinkle@example.com'
  user.password              'foobar'
  user.password_confirmation 'foobar'
end

Factory.define :event do |event|
  event.name           'Macclesfield Farmers Market'
  event.takes_place_on 1.week.from_now
  event.location       'Town Hall, Macclesfield'
end

Factory.define :supplier do |supplier|
  supplier.address '4 Buckingham Road, Thorpe Larches TS21 6FF'
  supplier.name 'Jack Green'
  supplier.telephone_number '077 3552 2248'
  supplier.website 'http://soldierresources.com/'
end