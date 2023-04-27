source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "tzinfo-data" # don't rely on OS timezone data

gem "rails", github: "rails/rails", branch: "main"

# Drivers
gem "sqlite3", "~> 1.4"
gem "mysql2"
gem "redis", "~> 4.0"
gem "sidekiq"
gem "sidekiq-cron"

gem "puma", "~> 5.0"

# Assets
gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# Security
gem "bcrypt", "~> 3.1.7"
gem "rack-cors"

gem "ziptz"
gem "faraday"

gem "phonelib"
gem "twilio-ruby"

gem "mrsk" # deployments
gem "appsignal"

gem "bootsnap", require: false # reduces boot times through caching; required in config/boot.rb

group :development, :test do
  gem "debug"
end

group :development do
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
