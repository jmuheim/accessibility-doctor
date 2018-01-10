class TrialSessionRequest < ApplicationRecord
  extend Enumerize
  include Humanizer

  require_human_on :create

  validates :datetime, presence: true
  validates :time_zone, presence: true
  validates :customer_name, presence: true
  validates :customer_email, presence: true
  validates :how_found_us, presence: true
  validates :agree_to_terms_and_conditions, presence: true

  enumerize :duration, in: [:quarter_hour], default: :quarter_hour
  enumerize :how_found_us, in: [:search_engine, :recommendation, :other]
end
