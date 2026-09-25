class Product < ActiveRecord::Base
  extend FriendlyId

  has_many :line_items, dependent: :restrict_with_error

  # Paperclip cropped each style to exactly these pixels with its "70x70#"
  # geometry, which is what resize_to_fill does. Named variants would read
  # better than a constant, but they arrive in Rails 7.0.
  PHOTO_SIZES = {
    order_summary: [70, 70],
    preview: [50, 50],
    show: [584, 399],
    thumbnail: [215, 133],
  }.freeze

  has_one_attached :photo

  validate :photo_is_an_image

  validates_presence_of :title
  validates_uniqueness_of :title

  friendly_id :title, use: [:slugged, :finders]
  monetize :price_pennies

  before_destroy :ensure_not_referenced_by_any_line_item

  def to_s
    title
  end

  def photo_variant(style)
    photo.variant(resize_to_fill: PHOTO_SIZES.fetch(style))
  end

  private

  # Rails 6.1 has no attachment validations of its own, so this stands in for
  # Paperclip's validates_attachment_content_type.
  def photo_is_an_image
    return unless photo.attached?
    return if photo.blob.content_type.to_s.start_with?("image/")

    errors.add(:photo, "must be an image")
  end

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
