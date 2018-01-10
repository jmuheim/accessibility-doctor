class TrialSessionRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :add_breadcrumbs
  respond_to :html

  def create
    @trial_session_request.save

    respond_with @trial_session_request
  end

  private

  def trial_session_request_params
    params.require(:trial_session_request).permit(:start_date,
                                         :end_date,
                                         :customer_name,
                                         :customer_email,
                                         :url,
                                         :description,
                                         :notes,
                                         :lock_version)
  end

  def add_breadcrumbs
    add_breadcrumb TrialSessionRequest.model_name.human(count: :other), trial_session_requests_path                    if [:index, :new, :create].include? action_name.to_sym
    add_breadcrumb @trial_session_request.id,                            trial_session_request_path(@trial_session_request)      if [:show, :edit, :update].include? action_name.to_sym
    add_breadcrumb t('actions.new'),                            new_trial_session_request_path                 if [:new,  :create].include?        action_name.to_sym
    add_breadcrumb t('actions.edit'),                           edit_trial_session_request_path(@trial_session_request) if [:edit, :update].include?        action_name.to_sym
  end
end
