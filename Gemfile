source 'http://rubygems.org'

ruby '2.1.2'

gem 'airbrake'
gem 'aws-sdk'
gem 'bourbon', '~> 3.2.1'
gem 'coffee-rails'
gem 'geocoder'
gem 'draper'
gem 'friendly_id'
gem 'jquery-rails'
gem 'kaminari'
gem 'money-rails'
gem 'neat', '~> 1.5.1'
gem 'paperclip'
gem 'pg'
gem 'rails', '4.1.4'
gem 'recipient_interceptor'
gem 'sass-rails', '~> 4.0.3'
gem 'stripe'
gem 'uglifier'
gem 'unicorn'

group :development do
  gem 'foreman'
end

group :development, :test do
  gem "byebug"
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0.0'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.7.3'
  gem 'rails_12factor'
end
