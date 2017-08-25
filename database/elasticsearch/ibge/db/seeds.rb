config = {
  host: "http://192.168.33.21:9200/",
  transport_options: {
    request: { timeout: 5 }
  },
  log: true
}

client = Elasticsearch::Client.new(config)

Person.delete_all
Person.create([
	{name: 'Richard', gender: 'M', birthyear: 1991},
	{name: 'Ketherin', gender: 'F', birthyear: 1991},
	{name: 'Cristina', gender: 'F', birthyear: 1965},
	{name: 'Carlos', gender: 'M', birthyear: 1949},
	{name: 'Alzira', gender: 'F', birthyear: 1944},
	{name: 'Geovah', gender: 'M', birthyear: 1933},
	{name: 'Marcos', gender: 'M', birthyear: 1967},
	{name: 'Shirley', gender: 'F', birthyear: 1967},
	{name: 'Raquel', gender: 'F', birthyear: 1967}
])

client.indices.delete index: 'people' rescue nil
client.index index: 'people', type: 'person', id: Person.first.id, body: Person.first.as_indexed_json, refresh: true
client.index index: 'people', type: 'person', id: Person.second.id, body: Person.second.as_indexed_json, refresh: true
client.index index: 'people', type: 'person', id: Person.third.id, body: Person.third.as_indexed_json, refresh: true

client.bulk index: 'people',
            type:  'person',
            body:  Person.all[3..-1].as_json.map { |a| { index: { _id: a.delete('id'), data: a } } },
            refresh: true
            
Person.first.__elasticsearch__.delete_document # Destroy only in ES
Person.new(name: 'Richard', gender: 'M', birthyear: 1992).__elasticsearch__.index_document # Create Only in ES
Person.first.__elasticsearch__.update_document # Recreate using existing document and ignoring last line
Person.first.__elasticsearch__.update_document_attributes(birthyear: 1992) # Update attributes for this document

# persons = Person.search('name: Richard') || Person.search('name: Rich*') || Person.search('_id: 1') || Person.search('name: Richard AND birthyear: 1992')
# persons.results.first._source.name