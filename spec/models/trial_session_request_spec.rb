require 'rails_helper'

RSpec.describe TrialSessionRequest do
  it { should validate_presence_of :availability }
  it { should validate_presence_of :time_zone }
  it { should validate_presence_of :name }
  it { should validate_presence_of :company }
  it { should validate_presence_of :email }
  it { should validate_presence_of :how_found_us }
  it { should validate_presence_of :agree_to_terms_and_conditions }

  describe 'url validation' do
    it 'accepts an empty url' do
      trial_session_request = build :trial_session_request, url: nil
      expect(trial_session_request).to be_valid
    end

    it 'accepts a valid HTTP url' do
      trial_session_request = build :trial_session_request, url: 'http://www.test.com'
      expect(trial_session_request).to be_valid
    end

    it 'accepts a valid HTTPS url' do
      trial_session_request = build :trial_session_request, url: 'https://www.test.com'
      expect(trial_session_request).to be_valid
    end

    it 'prepends the protocol if missing' do
      trial_session_request = build :trial_session_request, url: 'www.test.com'
      expect(trial_session_request).to be_valid
      expect(trial_session_request.url).to eq 'http://www.test.com'
    end

    it "doesn't accept an invalid url" do
      trial_session_request = build :trial_session_request, url: 'something invalid!'
      expect(trial_session_request.errors_on(:url)).to include 'is not a valid URL'
    end
  end

  describe 'humanizer captcha' do
    context 'on create' do
      it 'accepts a correct answer' do
        trial_session_request = build :trial_session_request
        trial_session_request.humanizer_question_id = '16' # What is fifteen divided by three?
        trial_session_request.humanizer_answer = '5'

        expect(trial_session_request).to be_valid
      end

      it 'rejects an incorrect answer' do
        trial_session_request = build :trial_session_request, attributes_for(:trial_session_request)
        trial_session_request.humanizer_answer = 'wrong answer'

        expect(trial_session_request).to be_invalid
        expect(trial_session_request.errors_on(:humanizer_answer)).to include "You're not a human"
      end
    end
  end

  describe 'versioning', versioning: true do
    it 'is versioned' do
      is_expected.to be_versioned
    end

    describe 'attributes' do
      before { @trial_session_request = create :trial_session_request }

      it 'versions starts_at' do
        expect {
          @trial_session_request.update_attributes! starts_at: Time.now + 1.week
        }.to change { @trial_session_request.versions.count }.by 1
      end

      it 'versions availability' do
        expect {
          @trial_session_request.update_attributes! availability: 'Tomorrow full day'
        }.to change { @trial_session_request.versions.count }.by 1
      end

      it 'versions time_zone' do
        expect {
          @trial_session_request.update_attributes! time_zone: 'Dublin'
        }.to change { @trial_session_request.versions.count }.by 1
      end

      it 'versions language' do
        expect {
          @trial_session_request.update_attributes! language: 'de'
        }.to change { @trial_session_request.versions.count }.by 1
      end

      it 'versions name' do
        expect {
          @trial_session_request.update_attributes! name: 'Other name'
        }.to change { @trial_session_request.versions.count }.by 1
      end






      it 'versions company' do
        expect {
          @trial_session_request.update_attributes! company: 'Other company'
        }.to change { @trial_session_request.versions.count }.by 1
      end

      it 'versions email' do
        expect {
          @trial_session_request.update_attributes! email: 'other@example.com'
        }.to change { @trial_session_request.versions.count }.by 1
      end

      it 'versions url' do
        expect {
          @trial_session_request.update_attributes! url: 'http://www.other-url.com'
        }.to change { @trial_session_request.versions.count }.by 1
      end

      it 'versions message' do
        expect {
          @trial_session_request.update_attributes! name: 'Hey mate! Great service.'
        }.to change { @trial_session_request.versions.count }.by 1
      end

      it 'versions how_found_us' do
        expect {
          @trial_session_request.update_attributes! how_found_us: 'recommendation'
        }.to change { @trial_session_request.versions.count }.by 1
      end

      it 'versions notes' do
        expect {
          @trial_session_request.update_attributes! notes: 'Some secret notes'
        }.to change { @trial_session_request.versions.count }.by 1
      end
    end
  end
end
