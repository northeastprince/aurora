Rails.application.configure do
  config.lograge.enabled = true

  config.lograge.custom_options = lambda do |event|
    exceptions = %w[controller action format id]
    {params: event.payload[:params].except(*exceptions)}
  end

  config.lograge.keep_original_rails_log = true
  config.lograge.logger = Appsignal::Logger.new("rails", format: Appsignal::Logger::LOGFMT)
end
