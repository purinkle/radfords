# frozen_string_literal: true

require_relative "boot"
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "active_storage/engine"
Bundler.require(*Rails.groups)
module Radfords
  class Application < Rails::Application
    config.load_defaults 6.1

    config.assets.quiet = true
    config.generators do |generate|
      generate.helper false
      generate.javascripts false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
    end
    # Hand every Ruby file a generator writes straight to RuboCop, so
    # generated code arrives already in this app's style.
    config.generators.after_generate do |files|
      parsable_files = files.filter { |file| file.end_with?(".rb") }
      unless parsable_files.empty?
        system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin}", exception: true)
      end
    end
    config.action_controller.action_on_unpermitted_parameters = :raise
    config.active_job.queue_adapter = :delayed_job
  end
end
