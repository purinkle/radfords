source 'http://rubygems.org'
ruby '2.1.0'

gem 'airbrake'
gem 'aws-sdk'
gem 'geocoder'
gem 'draper'
gem 'friendly_id'
gem 'jquery-rails'
gem 'kaminari'
gem 'money-rails'
gem 'paperclip'
gem 'pg'
gem 'rails'
gem 'recipient_interceptor'
gem 'unicorn'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
end

group :development do
  gem 'foreman'
  gem 'rails-footnotes'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'fuubar'
  gem 'launchy'
  gem 'shoulda'
  gem 'simplecov'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end

group :staging, :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end
