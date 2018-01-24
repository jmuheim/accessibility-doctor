FactoryBot.define do
  factory :trial_session_request do
    starts_at                     "2018-01-09 13:59:40"
    availability                  'Trial Session Request test availability'
    time_zone                     'Riga'
    language                      'en'
    name                          'Trial Session Request test name'
    company                       'Trial Session Request test company'
    email                         'test@example.com'
    url                           'http://www.example.com'
    message                       'Trial Session Request test message'
    how_found_us                  'other'
    agree_to_terms_and_conditions true
    humanizer_question_id         '16'
    humanizer_answer              '5'
  end
end
