json.extract! employee, :id, :name, :birthday, :gender, :city, :vacancy_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
