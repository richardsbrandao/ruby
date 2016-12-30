json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :email, :phone, :birthday, :facebook
  json.url contact_url(contact, format: :json)
end
