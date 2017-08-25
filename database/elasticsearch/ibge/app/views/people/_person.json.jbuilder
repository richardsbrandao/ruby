json.extract! person, :id, :name, :gender, :birthyear, :created_at, :updated_at
json.url person_url(person, format: :json)
