class Product < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :description, :photo, :photo_file_name, :title

  has_attached_file :photo,
    default_url: "/photos/original/missing_:style.png",
    storage: :s3,
    s3_credentials: {
      bucket: ENV['S3_BUCKET_NAME'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    },
    s3_host_name: ENV['S3_HOST_NAME'],
    styles: {preview: "50x50#"}

  validates_presence_of :title
  validates_uniqueness_of :title

  friendly_id :title, use: :slugged
end
