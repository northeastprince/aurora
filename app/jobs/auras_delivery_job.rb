class AurasDeliveryJob < ApplicationJob
  def perform(*specific_recipients)
    recipients = specific_recipients.any? ? specific_recipients : User.all

    recipients.each do |recipient|
      Aura.new(recipient).deliver
    end
  end
end
