require 'simplecov'
SimpleCov.start 'rails'
SimpleCov.coverage_dir 'coverage/rspec'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Formulaic::Dsl, type: :feature

  config.mock_with :rspec
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  def test_sign_in(user)
    controller.sign_in(user)
  end
end

ActiveRecord::Migration.maintain_test_schema!
