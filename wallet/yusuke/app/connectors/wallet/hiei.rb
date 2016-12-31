module Wallet
  module Hiei
    include Wallet::Service

    def find_indexers
      response = perform_request(:find_indexers, {})

      JSON.parse(response.body, symbolize_names: true)
    end

    def find_indexer(id)
      response = perform_request(:find_indexer, {id: id})

      JSON.parse(response.body, symbolize_names: true)
    end

    def find_variations_by_indexer(id)
      response = perform_request(:find_variation_by_indexer, {id: id})

      JSON.parse(response.body, symbolize_names: true)
    end

    def create(indexer)
      response = perform_request(:create_indexer, indexer)

      JSON.parse(response.body, symbolize_names: true)
    end

  end
end