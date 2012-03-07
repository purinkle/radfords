class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: true
end
