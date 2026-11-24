require "aws-sdk-s3"

# Paperclip stored each photo on S3 under a path it built from the product id,
# and recorded only the file name in the database. Active Storage keeps its own
# key, so the bytes have to be read from the old path and handed to it.
class PaperclipPhotoMigration
  def initialize(bucket:, out: $stdout, err: $stderr)
    @bucket = bucket
    @out = out
    @err = err
    @tally = Hash.new(0)
  end

  # Copies every photo across, reporting each product and then a total.
  def run
    products = Product.with_attached_photo.where.not(photo_file_name: nil)
    out.puts "#{products.count} products carry a Paperclip photo."
    products.find_each { |product| tally[migrate(product)] += 1 }
    out.puts summary
  end

  # True once a run has found no photo missing and had none refused.
  def succeeded?
    tally.values_at(:missing, :failed).sum.zero?
  end

  private

  attr_reader :bucket, :err, :out, :tally

  def summary
    attached, skipped, missing, failed = tally.values_at(:attached, :skipped, :missing, :failed)
    "Attached #{attached}, already done #{skipped}, missing #{missing}, failed #{failed}."
  end

  def migrate(product)
    return report(:skipped, product, "already on Active Storage, leaving it alone") if product.photo.attached?

    copy(product, product.paperclip_photo_key)
  end

  def copy(product, key)
    product.attach_paperclip_photo(bucket.object(key).get)
    return report(:attached, product, "attached from #{key}") if product.photo.attached?

    report(:failed, product, product.errors.full_messages.to_sentence, to: err)
  rescue Aws::S3::Errors::NoSuchKey
    report(:missing, product, "nothing at #{key}", to: err)
  end

  def report(outcome, product, message, to: out)
    to.puts "#{product.id}: #{message}."
    outcome
  end
end
