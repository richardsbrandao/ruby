json.array!(@addresses) do |address|
  json.extract! address, :id, :cep, :name, :neighborhood, :customer_id
  json.url address_url(address, format: :json)
end
