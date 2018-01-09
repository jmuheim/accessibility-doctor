class LiveSessionsController < ApplicationController
  load_and_authorize_resource
  before_action :add_breadcrumbs
  respond_to :html

  private

  def add_breadcrumbs
    add_breadcrumb LiveSession.model_name.human(count: :other), live_sessions_path if [:index, :new, :create].include? action_name.to_sym
    add_breadcrumb @live_session.id, live_session_path(@live_session)      if [:show, :edit, :update].include? action_name.to_sym
    add_breadcrumb t('actions.new'),                new_live_session_path         if [:new,  :create].include?        action_name.to_sym
    add_breadcrumb t('actions.edit'),               edit_live_session_path(@live_session) if [:edit, :update].include?        action_name.to_sym
  end
end
