class AurasDeliveryJob < ApplicationJob
  def perform(*specific_recipients)
    recipients = specific_recipients.any? ? specific_recipients : User.all

    recipients.each do |recipient|
      AuraDeliveryJob.perform_later(recipient)
    end
  end
end
