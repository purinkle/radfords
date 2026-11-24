Rails.application.configure do
  # Raise on a lazily loaded association, so every N+1 query is caught
  # where it is written and the association has to be preloaded instead.
  config.active_record.strict_loading_by_default = true

  config.cache_classes = false
  config.action_view.cache_template_loading = true
  # Load the whole app on CI, so a file that fails to load fails the build
  # even when no spec touches it. Locally, keep single spec runs quick.
  config.eager_load = ENV["CI"].present?
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=#{1.hour.to_i}"
  }
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.active_storage.service = :test
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :stderr
  config.i18n.raise_on_missing_translations = true
  config.assets.raise_runtime_errors = true
  config.action_mailer.default_url_options = { host: "www.example.com" }
  config.action_mailer.asset_host = { host: "www.example.com" }
  config.active_job.queue_adapter = :inline
end
