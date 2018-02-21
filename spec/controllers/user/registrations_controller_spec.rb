require 'rails_helper'

describe User::RegistrationsController do
  before(:each) { @request.env["devise.mapping"] = Devise.mappings[:user] }
  context 'creating a new registration request' do
    it 'remembers when the form was displayed' do
      get :new
      expect(@request.session['form_timestamp']).not_to be_nil
    end
  end
end
