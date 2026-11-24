# Strict loading is there to catch this app's own N+1 queries. Active
# Storage loads its records' associations itself, inside jobs and callbacks
# the app never sees: purging a blob loads its variant records, and purging
# a variant record loads its own attachment. Leave its models out, so those
# loads run instead of raising. The app's models stay strict, so a page
# that forgets to preload a photo still fails.
Rails.application.config.to_prepare do
  [ActiveStorage::Attachment, ActiveStorage::Blob, ActiveStorage::VariantRecord].each do |model|
    model.strict_loading_by_default = false
  end
end
