# == Schema Information
#
# Table name: suppliers
#
#  id               :integer         not null, primary key
#  address          :string(255)
#  name             :string(255)
#  telephone_number :string(255)
#  website          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Supplier < ActiveRecord::Base
  validates :address, presence: true
  validates :name, presence: true
  validates :telephone_number, presence: true
  geocoded_by :address
  after_validation :geocode
end
