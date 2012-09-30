class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :title

  validates_presence_of :title
  validates_uniqueness_of :title
end
