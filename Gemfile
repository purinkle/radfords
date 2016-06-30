source "https://rubygems.org"

ruby "2.3.1"

gem "autoprefixer-rails"
gem "aws-sdk"
gem "delayed_job_active_record"
gem "draper"
gem "flutie"
gem "friendly_id"
gem "geocoder"
gem "honeybadger"
gem "jquery-rails"
gem "kaminari"
gem "money-rails"
gem "normalize-rails", "~> 3.0.0"
gem "paperclip"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 4.2.0"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "skylight"
gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"
gem "stripe"
gem "suspenders"
gem "title"
gem "uglifier"

group :development do
  gem "quiet_assets"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.4.0"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "vcr"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
  gem "rails_stdout_logging"
end

gem "high_voltage"
gem "bourbon", "5.0.0.beta.6"
gem "neat", "~> 1.8.0"
gem "refills", group: [:development, :test]
