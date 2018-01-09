json.extract! live_session, :id, :start_date, :end_date, :customer_name, :customer_email, :url, :description, :notes, :created_at, :updated_at
json.url live_session_url(live_session, format: :json)
