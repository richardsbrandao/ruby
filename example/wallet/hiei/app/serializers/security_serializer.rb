class SecuritySerializer < ActiveModel::Serializer
  attributes :id, :name, :tax_type, :expiration, :yield_type, :indexer_id
end
