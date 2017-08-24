ELASTIC_SEARCH_FILE = 'config/elasticsearch.yml'

ELASTIC_SEARCH_CONFIG = YAML.load_file(Rails.root.join(ELASTIC_SEARCH_FILE))[Rails.env].deep_symbolize_keys

Elasticsearch::Model.client = Elasticsearch::Client.new(ELASTIC_SEARCH_CONFIG)