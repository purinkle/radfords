# == Schema Information
#
# Table name: events
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  takes_place_on :date
#  location       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Event < ActiveRecord::Base
  validates :name, :presence => true;
  validates :takes_place_on, :presence => true;
  validates :location, :presence => true;
end
