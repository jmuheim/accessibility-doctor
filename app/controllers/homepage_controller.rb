class HomepageController < ApplicationController
  before_action :add_breadcrumbs

  private

  def check_authorization?
    false
  end

  def authenticate_user?
    false
  end

  def add_breadcrumbs
    case action_name
    when 'i_am'
      add_breadcrumb 'I am', i_am_path
    when 'i_offer'
      add_breadcrumb 'I offer', i_offer_path
    when 'i_charge'
      add_breadcrumb 'I charge', i_charge_path
    end
  end
end
