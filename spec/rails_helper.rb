ENV["RACK_ENV"] = "test"

require File.expand_path("../config/environment", __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"

Rails.root.glob("spec/support/**/*.rb").each { |file| require file }

module Features
  # Extend this module in spec/support/features/*.rb
  include Formulaic::Dsl
end

RSpec.configure do |config|
  # A controller spec skips the middleware that resets Current after each
  # request, so reset it here instead.
  config.before { Current.reset }
  config.include Features, type: :feature
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
end

ActiveRecord::Migration.maintain_test_schema!
