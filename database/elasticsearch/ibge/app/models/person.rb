class Person < ApplicationRecord
	include Elasticsearch::Model
  	include Elasticsearch::Model::Callbacks

  	# index_name Rails.application.class.parent_name.underscore
  	# document_type self.name.downcase

  	def as_indexed_json(options = nil) 
  		self.as_json( only: [ :name, :gender, :birthyear ] ) 
  	end

  	# def self.search(query) 
  	# 	__elasticsearch__.search( 
  	# 		{ 
  	# 			query: { multi_match: { query: query, fields: ['name', 'gender'] } } 
  	# 		} 
  	# 	) 
  	# end
end
