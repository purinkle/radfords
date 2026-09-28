source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.11"

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
gem "pg"
gem "puma", "< 6.0"
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
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 4.1"
end

group :test do
  gem "capybara-selenium"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  # webdrivers 5.3.1 caps selenium-webdriver below 4.11, and webdrivers 5.3 is
  # the first release to look chromedriver up through Chrome for Testing. Ruby
  # no longer caps it. Selenium manages drivers itself from 4.11, so the exit
  # from this pair is to drop webdrivers, not to bump it.
  gem "selenium-webdriver", "~> 4.1.0"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "vcr"
  gem "webdrivers", "~> 5.3"
  gem "webmock"
end

group :production do
  gem "heroku-deflater"
  gem "rack-timeout"
end

gem "bourbon", "~> 7.3.0"
gem "high_voltage"
gem "refills", group: %i[development test]
