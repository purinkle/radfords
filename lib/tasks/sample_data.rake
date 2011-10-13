namespace :db do
  desc "Fill database with sample data"

  task :populate => :environment do
    Rake::Task["db:reset"].invoke

    Event.create!( :name => "Macclesfield Farmers' Market",
                   :takes_place_on => "2 October 2011",
                   :location => "Town Hall, Macclesfield" )

    99.times do |n|
      name = Faker::Name.name
      takes_place_on = "13 October 2011"
      location = "East Didsbury, Manchester"

      Event.create!( :name => name, :takes_place_on => takes_place_on,
                     :location => location )
    end
  end
end