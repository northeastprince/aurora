require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Aurora
  class Application < Rails::Application
    config.load_defaults 7.1

    config.active_record.encryption.support_unencrypted_data = true

    config.active_record.encryption.primary_key = ENV["PRIMARY_ENCRYPTION_KEY"]
    config.active_record.encryption.deterministic_key = ENV["DETERMINISTIC_ENCRYPTION_KEY"]
    config.active_record.encryption.key_derivation_salt = ENV["ENCRYPTION_KEY_DERIVATION_SALT"]
  end
end
