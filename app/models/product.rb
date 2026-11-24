class Product < ApplicationRecord
  extend FriendlyId

  has_many :line_items, dependent: :restrict_with_error

  # Paperclip cropped each style to exactly these pixels with its "70x70#"
  # geometry, which is what resize_to_fill does. Named variants would read
  # better than a constant, but they arrive in Rails 7.0.
  PHOTO_SIZES = {
    order_summary: [70, 70],
    preview: [50, 50],
    show: [584, 399],
    thumbnail: [215, 133]
  }.freeze

  has_one_attached :photo

  validate :photo_is_an_image

  validates :title, presence: true
  validates :title, uniqueness: true

  friendly_id :title, use: %i[slugged finders]
  monetize :price_pennies

  def to_s
    title
  end

  def photo_variant(style)
    photo.variant(resize_to_fill: PHOTO_SIZES.fetch(style))
  end

  # Paperclip's :id_partition, which padded the id to nine digits and split
  # it into threes, so product 501 kept its photo under 000/000/501. This and
  # attach_paperclip_photo go once the photo_* columns are dropped.
  def paperclip_photo_key
    partition = format("%09d", id).scan(/\d{3}/).join("/")
    "product/photos/#{partition}/original/#{photo_file_name}"
  end

  # Attaches the bytes of the S3 object Paperclip stored this photo in.
  def attach_paperclip_photo(object)
    photo.attach(
      io: StringIO.new(object.body.read),
      filename: photo_file_name,
      content_type: photo_content_type.presence || object.content_type
    )
  end

  private

  # Rails 6.1 has no attachment validations of its own, so this stands in for
  # Paperclip's validates_attachment_content_type.
  def photo_is_an_image
    return unless photo.attached?
    return if photo.blob.content_type.to_s.start_with?("image/")

    errors.add(:photo, "must be an image")
  end
end
