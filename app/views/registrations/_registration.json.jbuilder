json.extract! registration, :id, :student_id, :team_id, :year, :idfb, :created_at, :updated_at
json.url registration_url(registration, format: :json)
