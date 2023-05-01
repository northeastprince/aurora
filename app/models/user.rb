class User < ApplicationRecord
  validates :first_name, presence: true, length: { maximum: 22 }
  validates :phone_number, presence: true, uniqueness: true, phone: { possible: true, countries: [:us] }
  before_save -> (user) { user.phone_number = Phonelib.parse(user.phone_number).e164 }
  validates :zip_code, presence: true, length: { is: 5 }, numericality: { only_integer: true }

  has_many :auras

  def current_temp_in_fahrenheit
    connection = Faraday.new("https://api.weatherapi.com") { |connection| connection.response :json }
    response = connection.get("/v1/forecast.json?key=#{ENV["WEATHERAPI_KEY"]}&q=#{zip_code}&days=1&aqi=no&alerts=no")
    response.body["current"]["temp_f"].to_i
  end
end
