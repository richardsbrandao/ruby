json.array!(@posts) do |post|
  json.extract! post, :id, :title, :description, :date
  json.url post_url(post, format: :json)
end
