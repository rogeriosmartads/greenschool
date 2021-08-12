json.extract! user, :id, :name, :kind, :status, :created_at, :updated_at
json.url user_url(user, format: :json)
