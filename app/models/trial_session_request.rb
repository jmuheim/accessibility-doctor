class TrialSessionRequest < ApplicationRecord
  extend Enumerize
  include Humanizer

  require_human_on :create

  has_paper_trail except: [:agree_to_terms_and_conditions, :lock_version, :created_at, :updated_at]

  validates :availability, presence: true
  validates :time_zone, presence: true
  validates :name, presence: true
  validates :company, presence: true
  validates :email, presence: true
  validates :how_found_us, presence: true
  validates :agree_to_terms_and_conditions, presence: true
  validates :url, url: { allow_nil: true }

  enumerize :duration, in: [:quarter_hour], default: :quarter_hour
  enumerize :language, in: [:en, :de], default: :en
  enumerize :how_found_us, in: [:search_engine, :recommendation, :other]

  before_validation :add_url_protocol_if_missing!

  protected

  def add_url_protocol_if_missing!
    self.url = "http://#{url}" unless url.blank? || url[/\Ahttps?:\/\//]
  end
end
