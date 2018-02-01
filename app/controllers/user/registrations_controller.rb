class User::RegistrationsController < Devise::RegistrationsController
  # Time a user should need at minimum to fill out the form
  MIN_INPUT_TIME = 3.seconds

  # Would like to use `before_action :authenticate_user!`, but doesn't work. See http://stackoverflow.com/questions/42938450/devise-cancan-route-get-user-registration-path-isnt-available-how-to-create
  before_action :load_current_user
  load_and_authorize_resource class: 'User', only: :show
  before_action :add_breadcrumbs
  after_action :set_form_timestamp, only: [:new, :create]

  def create
    return super if time_required_for_input > MIN_INPUT_TIME
    flash[:danger] = t 'shared.to_fast'
    redirect_back(fallback_location: root_path)
  end

  private

  def load_current_user
    @user = current_user
  end

  def add_breadcrumbs
    add_breadcrumb current_user.name,                    user_registration_path     if [:show, :edit, :update].include? action_name.to_sym
    add_breadcrumb t('devise.registrations.new.title'),  new_user_registration_path if [:new,  :create].include?        action_name.to_sym
    add_breadcrumb t('devise.registrations.edit.title'), new_user_registration_path if [:edit, :update].include?        action_name.to_sym
  end
end
