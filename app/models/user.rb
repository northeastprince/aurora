class User < ApplicationRecord
  validates :first_name, presence: true, length: {maximum: 22}
  validates :phone_number, presence: true, uniqueness: true, phone: {possible: true, countries: [:us]}
  before_save ->(user) { user.phone_number = Phonelib.parse(user.phone_number).e164 }
  validates :zip_code, zipcode: {country_code: :us}
  validate :zip_code_exists, if: -> { errors.none? }

  has_many :auras

  def current_temp_in_fahrenheit
    connection = Faraday.new("https://api.weatherapi.com") { |connection| connection.response :json }
    response = connection.get("/v1/forecast.json?key=#{ENV["WEATHERAPI_KEY"]}&q=#{zip_code}&days=1&aqi=no&alerts=no")

    if (temp = response.body.dig("current", "temp_f"))
      temp.to_i
    end
  end

  private

  def zip_code_exists
    if current_temp_in_fahrenheit.nil? && with(zip_code: "02462") { current_temp_in_fahrenheit.present? }
      errors.add(:zip_code, "does not exist")
    end
  end
end
