json.extract! vacancy, :id, :position, :salary, :company_id, :created_at, :updated_at
json.url vacancy_url(vacancy, format: :json)
