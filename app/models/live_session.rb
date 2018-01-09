class LiveSession < ApplicationRecord
  validates :start_date, presence: true
  validates :customer_name, presence: true
  validates :customer_email, presence: true
  validates :url, presence: true
end
