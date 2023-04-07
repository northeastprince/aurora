class User < ApplicationRecord
  validates :first_name, presence: true, length: { maximum: 22 }
  validates :phone_number, presence: true, uniqueness: true, phone: { possible: true, countries: [:us] }
  before_save -> (user) { user.phone_number = Phonelib.parse(user.phone_number).e164 }
  validates :zip_code, presence: true, length: { is: 5 }, numericality: { only_integer: true }
end
