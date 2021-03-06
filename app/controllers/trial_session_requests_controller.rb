class TrialSessionRequestsController < ApplicationController
  load_and_authorize_resource
  provide_optimistic_locking
  before_action :add_breadcrumbs
  respond_to :html

  def create
    if @trial_session_request.save
      TrialSessionRequestMailer.thank_you(@trial_session_request).deliver_now
      TrialSessionRequestMailer.new_request(@trial_session_request).deliver_now
    end

    respond_with @trial_session_request
  end

  def update
    @trial_session_request.update(trial_session_request_params)
    respond_with @trial_session_request
  end

  def destroy
    @trial_session_request.destroy
    respond_with @trial_session_request
  end

  private

  def trial_session_request_params
    params.require(:trial_session_request).permit(:availability,
                                                  :starts_at,
                                                  :time_zone,
                                                  :name,
                                                  :email,
                                                  :company,
                                                  :url,
                                                  :how_found_us,
                                                  :message,
                                                  :agree_to_terms_and_conditions,
                                                  :lock_version,
                                                  :humanizer_question_id,
                                                  :humanizer_answer,
                                                  :language)
  end

  def add_breadcrumbs
    add_breadcrumb TrialSessionRequest.model_name.human(count: :other), trial_session_requests_path                             if [:index, :new, :create, :show, :edit, :update].include? action_name.to_sym
    add_breadcrumb @trial_session_request.name,                         trial_session_request_path(@trial_session_request)      if [:show, :edit, :update].include?                        action_name.to_sym
    add_breadcrumb t('actions.new'),                                    new_trial_session_request_path                          if [:new,  :create].include?                               action_name.to_sym
    add_breadcrumb t('actions.edit'),                                   edit_trial_session_request_path(@trial_session_request) if [:edit, :update].include?                               action_name.to_sym
  end

  def authenticate_user?
    !['new', 'create', 'show'].include? action_name
  end
end
