# Run this once, after deploying, and before the Paperclip columns are dropped.
# PaperclipPhotoMigration explains why the bytes have to be copied.
namespace :photos do
  desc "Copy each product's Paperclip photo on S3 across to Active Storage"
  task migrate_from_paperclip: :environment do
    require Rails.root.join("lib/paperclip_photo_migration").to_s

    client = Aws::S3::Client.new(
      region: ENV.fetch("S3_REGION"),
      access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
      secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY")
    )
    bucket = Aws::S3::Bucket.new(name: ENV.fetch("S3_BUCKET_NAME"), client: client)
    migration = PaperclipPhotoMigration.new(bucket: bucket)
    migration.run

    abort("These products' photos did not come across: #{migration.failures.join(", ")}.") if migration.failures.any?
  end
end
