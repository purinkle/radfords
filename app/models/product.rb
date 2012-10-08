class Product < ActiveRecord::Base
  attr_accessible :description, :photo, :title

  has_attached_file :photo,
    storage: :s3,
    s3_credentials: {
      bucket: ENV['S3_BUCKET_NAME'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    },
    s3_host_name: ENV['S3_HOST_NAME']

  validates_presence_of :title
  validates_uniqueness_of :title
end
