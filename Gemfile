source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "tzinfo-data" # don't rely on OS timezone data

gem "dotenv-rails"

gem "rails", github: "rails/rails", branch: "main"

# Drivers
gem "pg"
gem "redis"
gem "sidekiq"
gem "sidekiq-cron"

gem "puma"

# Assets
gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# Security
gem "rack-cors"

gem "phonelib"

gem "validates_zipcode"
gem "ziptz"

# External Services & APIs
gem "faraday"
gem "twilio-ruby"

gem "kamal" # deployments
gem "lograge"
gem "appsignal" # monitoring

gem "bootsnap", require: false # reduces boot times through caching; required in config/boot.rb

group :development, :test do
  gem "debug"

  # Code Critics
  gem "standard"
  gem "standard-rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
