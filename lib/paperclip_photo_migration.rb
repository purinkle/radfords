require "aws-sdk-s3"

# Paperclip stored each photo on S3 under a path it built from the product id,
# and recorded only the file name in the database. Active Storage keeps its own
# key, so the bytes have to be read from the old path and handed to it.
class PaperclipPhotoMigration
  # The ids of the products whose photo did not come across.
  attr_reader :failures

  def initialize(bucket:, out: $stdout)
    @bucket = bucket
    @out = out
    @failures = []
  end

  # Copies every photo not yet on Active Storage, one line per product.
  def run
    Product.paperclip_photos_to_copy.find_each do |product|
      @out.puts "#{product.id}: #{copy(product, product.paperclip_photo_key)}."
    end
  end

  private

  def copy(product, key)
    product.attach_paperclip_photo(@bucket.object(key).get)
    product.photo.attached? ? "attached from #{key}" : failed(product, product.errors.full_messages.to_sentence)
  rescue Aws::S3::Errors::NoSuchKey
    failed(product, "nothing at #{key}")
  end

  def failed(product, reason)
    failures << product.id
    reason
  end
end
