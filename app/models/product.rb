class Product < ActiveRecord::Base
  attr_accessible :description, :photo, :title

  has_attached_file :photo

  validates_presence_of :title
  validates_uniqueness_of :title
end
