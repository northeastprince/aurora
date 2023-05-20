class AuraDeliveryJob < ApplicationJob
  def perform(recipient)
    recipient.auras.create!.deliver
  end
end
