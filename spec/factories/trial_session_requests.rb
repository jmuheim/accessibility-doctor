FactoryBot.define do
  factory :trial_session_request do
    starts_at "2018-01-09 13:59:40"
    availability 'Trial Session Request test availability'
    time_zone 'Trial Session Request time_zone'
    language 'en'
    name 'Trial Session Request name'
    company 'Trial Session Request company'
    email 'Trial Session Request email'
    url 'http://www.example.com'
    message 'Trial Session Request message'
    how_found_us 'other'
    notes 'Trial Session Request notes'
    agree_to_terms_and_conditions true
    humanizer_question_id 16
    humanizer_answer 5
  end
end
