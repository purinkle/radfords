source "https://rubygems.org"

ruby "2.5.9"

gem "autoprefixer-rails"
gem "aws-sdk", "< 3"
gem "delayed_job_active_record"
gem "flutie"
gem "friendly_id"
gem "geocoder"
gem "honeybadger"
gem "jquery-rails"
gem "kaminari"
gem "money-rails"
gem "paperclip"
gem "pg"
gem "puma", "< 6.0"
gem "rack-canonical-host"
gem "rails", "~> 5.1.7"
gem "recipient_interceptor"
gem "sass-rails", "~> 6.0"
gem "simple_form"
gem "skylight"
gem "sprockets", ">= 3.0.0"
gem "stripe"
gem "suspenders"
gem "title"
gem "uglifier"

group :development do
  gem "listen"
  gem "spring", "~> 2.1"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 4.1"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "capybara-selenium"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "vcr"
  gem "webdrivers"
  gem "webmock"
end

group :staging, :production do
  gem "heroku-deflater"
  gem "rack-timeout"
end

gem "bourbon", "~> 5.1.0"
gem "high_voltage"
gem "neat", "~> 4.0.0"
gem "refills", group: %i[development test]
