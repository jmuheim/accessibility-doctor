class TrialSessionRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :add_breadcrumbs
  respond_to :html

  def create
    TrialSessionRequestMailer.thank_you_email(@user).deliver_now if @trial_session_request.save

    respond_with @trial_session_request
  end

  def update
    @trial_session_request.update(trial_session_request_params)
    respond_with @trial_session_request
  end

  private

  def trial_session_request_params
    params.require(:trial_session_request).permit(:datetime,
                                                  :time_zone,
                                                  :name,
                                                  :email,
                                                  :company,
                                                  :url,
                                                  :how_found_us,
                                                  :message,
                                                  :agree_to_terms_and_conditions,
                                                  :lock_version,
                                                  :humanizer_answer,
                                                  :language,
                                                  :humanizer_question_id)
  end

  def add_breadcrumbs
    add_breadcrumb TrialSessionRequest.model_name.human(count: :other), trial_session_requests_path                    if [:index, :new, :create, :show].include? action_name.to_sym
    add_breadcrumb @trial_session_request.id.to_s,                            trial_session_request_path(@trial_session_request)      if [:show, :edit, :update].include? action_name.to_sym
    add_breadcrumb t('actions.new'),                            new_trial_session_request_path                 if [:new,  :create].include?        action_name.to_sym
    add_breadcrumb t('actions.edit'),                           edit_trial_session_request_path(@trial_session_request) if [:edit, :update].include?        action_name.to_sym
  end

  def authenticate_user?
    !['new', 'create', 'show'].include? action_name
  end
end
