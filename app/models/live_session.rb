class LiveSession < ApplicationRecord
  extend Enumerize

  validates :datetime, presence: true
  validates :duration, presence: true
  validates :customer_name, presence: true
  validates :customer_email, presence: true
  validates :url, presence: true

  enumerize :duration, in: [:quarter_hour], default: :quarter_hour
end
