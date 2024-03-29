class User < ApplicationRecord
  encrypts :first_name
  encrypts :phone_number, :zip_code, deterministic: true

  validates :first_name, presence: true, length: {maximum: 22}

  before_validation -> { self.phone_number = Phonelib.parse(phone_number).e164 }, if: -> { Phonelib.valid?(phone_number) }
  validates :phone_number, uniqueness: true, phone: {possible: true, countries: [:us]}

  validates :zip_code, zipcode: {country_code: :us}
  validate :zip_code_exists, if: -> { errors.none? }

  has_many :auras

  def current_temp_in_fahrenheit
    connection = Faraday.new("https://api.weatherapi.com") { |connection| connection.response :json }
    response = connection.get("/v1/forecast.json?key=#{Rails.application.credentials.weatherapi_key!}&q=#{zip_code}&days=1&aqi=no&alerts=no")

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
