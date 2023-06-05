module User::Verifiable
  extend ActiveSupport::Concern

  included do
    after_create_commit -> { request_verification }

    scope :verified, -> { not_pending }
  end

  def verified?
    status != :pending
  end

  def request_verification
    update!(status: :pending)
  end

  def verify
    update!(status: :active) unless verified?
  end
end
