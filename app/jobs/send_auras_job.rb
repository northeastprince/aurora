class SendAurasJob < ApplicationJob
  def perform(*args)
    User.in_batches.each_record do |user|
      Aura.new(user).send
    end
  end
end
