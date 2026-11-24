source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.13"

gem "autoprefixer-rails"
gem "aws-sdk-s3", require: false
gem "bootsnap", require: false
gem "delayed_job_active_record"
gem "flutie"
gem "friendly_id"
gem "geocoder"
gem "honeybadger"
gem "image_processing"
gem "inline_svg"
gem "jquery-rails"
gem "kaminari"
gem "money-rails"
# Ruby 3.4 dropped these from the default gems, and Rails 6.1 still reaches
# for them without declaring them. Drop each one as a later Rails release
# stops reaching for it.
gem "csv"
gem "drb"
gem "mutex_m"
gem "observer"
# RuboCop pulls json into the bundle, and json 3 rejects the quirks_mode
# option that Rails 6.1 still passes when it encodes. Drop the cap once a
# later Rails release stops passing it.
gem "json", "< 3"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 6.1.0"
gem "recipient_interceptor"
gem "sass-rails"
gem "simple_form"
gem "skylight"
gem "sprockets"
gem "stripe"
gem "suspenders"
gem "title"
gem "webpacker"

group :development do
  gem "rack-mini-profiler", require: false
  gem "spring-commands-rspec"
  gem "spring-watcher-listen"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "brakeman", require: false
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "bundler-integrity", require: false
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 4.1"
  gem "rubocop", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "rubocop-rubycw", require: false
  gem "rubycritic", require: false
end

group :test do
  gem "capybara-selenium"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "vcr"
  gem "webmock"
end

group :production do
  gem "heroku-deflater"
  gem "rack-timeout"
end

gem "bourbon", "~> 7.3.0"
gem "high_voltage"
gem "refills", group: %i[development test]
