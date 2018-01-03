json.extract! event, :id, :date_event, :name, :description, :min_age, :seats, :price, :created_at, :updated_at
json.url event_url(event, format: :json)
