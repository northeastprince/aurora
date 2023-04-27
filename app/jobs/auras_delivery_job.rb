class AurasDeliveryJob < ApplicationJob
  def perform(*args)
    User.find_each do |user|
      Aura.new(user).deliver
    end
  end
end
