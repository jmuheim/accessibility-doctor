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
    when 'we_are'
      add_breadcrumb t('homepage.we_are.title'), we_are_path
    when 'we_offer'
      add_breadcrumb t('homepage.we_offer.title'), we_offer_path
    when 'we_charge'
      add_breadcrumb t('homepage.we_charge.title'), we_charge_path
    when 'terms_and_conditions'
      add_breadcrumb t('homepage.terms_and_conditions.title'), terms_and_conditions_path
    end
  end
end
