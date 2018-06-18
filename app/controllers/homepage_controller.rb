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
      add_breadcrumb t('homepage.i_am.title'), i_am_path
    when 'i_offer'
      add_breadcrumb t('homepage.i_offer.title'), i_offer_path
    when 'i_charge'
      add_breadcrumb t('homepage.i_charge.title'), i_charge_path
    when 'terms_and_conditions'
      add_breadcrumb t('homepage.terms_and_conditions.title'), terms_and_conditions_path
    end
  end
end
