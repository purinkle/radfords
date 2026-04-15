source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "autoprefixer-rails"
gem "aws-sdk", "< 3"
gem "bootsnap", require: false
gem "delayed_job_active_record"
gem "flutie"
gem "friendly_id"
gem "geocoder"
gem "honeybadger"
gem "inline_svg"
gem "jquery-rails"
gem "kaminari"
gem "money-rails"
gem "paperclip", "~> 5.1.0"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 7.2.0"
gem "recipient_interceptor"
gem "sass-rails"
gem "simple_form"
gem "skylight"
gem "sprockets"
gem "stripe"
gem "suspenders"
gem "title"
gem "webpacker"
gem "webrick"

group :development do
  gem "rack-mini-profiler", require: false
  gem "spring-commands-rspec"
  gem "spring-watcher-listen"
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
  gem "rspec-rails", "~> 6.0"
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

group :production do
  gem "heroku-deflater"
  gem "rack-timeout"
end

gem "bourbon", "~> 7.0"
gem "high_voltage"
gem "refills", group: %i[development test]
