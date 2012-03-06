class Product < ActiveRecord::Base
  validates :title, :description, presence: true
end
