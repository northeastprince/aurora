module User::Status
  extend ActiveSupport::Concern

  included do
    enum status: {pending: 0, active: 1, inactive: 2}
  end
end
