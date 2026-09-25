# Paperclip stored each photo on S3 under a path it built from the product id,
# and recorded only the file name in the database. Active Storage keeps its own
# key, so the bytes have to be read from the old path and handed to it. Run this
# once, after deploying, and before the Paperclip columns are dropped.
namespace :photos do
  desc "Copy each product's Paperclip photo on S3 across to Active Storage"
  task migrate_from_paperclip: :environment do
    bucket = ENV.fetch("S3_BUCKET_NAME")
    client = Aws::S3::Client.new(
      region: ENV.fetch("S3_REGION"),
      access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
      secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
    )

    # Paperclip's :id_partition, which padded the id to nine digits and split it
    # into threes, so product 501 lived under 000/000/501.
    paperclip_key = lambda do |product|
      partition = format("%09d", product.id).scan(/\d{3}/).join("/")
      "product/photos/#{partition}/original/#{product.photo_file_name}"
    end

    products = Product.where.not(photo_file_name: nil).order(:id)
    puts "#{products.count} products carry a Paperclip photo."

    attached = skipped = missing = failed = 0

    products.find_each do |product|
      if product.photo.attached?
        puts "#{product.id}: already on Active Storage, leaving it alone."
        skipped += 1
        next
      end

      key = paperclip_key.call(product)

      begin
        object = client.get_object(bucket: bucket, key: key)
      rescue Aws::S3::Errors::NoSuchKey
        warn "#{product.id}: nothing at #{key}."
        missing += 1
        next
      end

      product.photo.attach(
        io: StringIO.new(object.body.read),
        filename: product.photo_file_name,
        content_type: product.photo_content_type.presence || object.content_type,
      )

      if product.photo.attached?
        puts "#{product.id}: attached from #{key}."
        attached += 1
      else
        warn "#{product.id}: #{product.errors.full_messages.to_sentence}."
        failed += 1
      end
    end

    puts "Attached #{attached}, already done #{skipped}, " \
      "missing #{missing}, failed #{failed}."
    abort("Some photos did not come across.") if missing.positive? || failed.positive?
  end
end
