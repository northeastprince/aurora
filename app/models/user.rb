class User < ApplicationRecord
  validates :first_name, presence: true, length: { maximum: 22 }
  validates :phone_number, presence: true, uniqueness: true, phone: { possible: true, countries: [:us] }
  before_save -> (user) { user.phone_number = Phonelib.parse(user.phone_number).e164 }
  validate :zip_code_exists

  has_many :auras

  def current_temp_in_fahrenheit
    connection = Faraday.new("https://api.weatherapi.com") { |connection| connection.response :json }
    response = connection.get("/v1/forecast.json?key=#{ENV["WEATHERAPI_KEY"]}&q=#{zip_code}&days=1&aqi=no&alerts=no")
    response.body["current"]["temp_f"].to_i
  end

  private

  def zip_code_exists
    if zip_code.blank? || zip_code.length != 5 || zip_code !~ ActiveModel::Validations::NumericalityValidator::INTEGER_REGEX
      errors.add(:zip_code, "is invalid")
    elsif location = Geocoder.search(zip_code).first&.data["address"]
      errors.add(:zip_code, "doesn't exist") unless location["country_code"] == "us" && location["postcode"].starts_with?(zip_code)
    end
  end
end
