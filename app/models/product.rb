class Product < ActiveRecord::Base
  extend FriendlyId

  has_many :line_items, dependent: :restrict_with_error

  has_attached_file :photo,
    default_url: "/photos/original/missing_:style.png",
    storage: :s3,
    s3_credentials: {
      bucket: ENV['S3_BUCKET_NAME'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    },
    s3_region: ENV["S3_REGION"],
    path: "product/:attachment/:id_partition/:style/:filename",
    url: ":s3_domain_url",
    styles: {
      order_summary: "70x70#",
      preview: "50x50#",
      show: "584x399#",
      thumbnail: "215x133#",
    }

  validates_attachment_content_type :photo, content_type: /\Aimage/

  validates_presence_of :title
  validates_uniqueness_of :title

  friendly_id :title, use: [:slugged, :finders]
  monetize :price_pennies

  before_destroy :ensure_not_referenced_by_any_line_item

  def to_s
    title
  end

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
