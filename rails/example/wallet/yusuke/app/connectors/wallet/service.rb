module Wallet
  module Service

    def perform_request(request, params)
      response = do_request(request, params)

      unless response_ok? response
        Rails.logger.info "::Hiei::#{response}"
      end

      response
    end

    private
    def do_request(request, params)
      case request
        when :find_indexers
          response = Connection.get('/indexers')
        when :find_indexer
          response = Connection.get("/indexers/#{params[:id]}")
        when :find_variation_by_indexer
          response = Connection.get("/indexers/#{params[:id]}/variations")
        when :create_indexer
          response = Connection.post('/indexers', :body => {name: params[:name], description: params[:description]}.to_json, :headers => { 'Content-Type' => 'application/json' })
      end
      response
    end

    def response_ok? response
      unless response.nil? || ! response.body.is_a?(String)
        return (200...400).include?(response.code)
      end

      false
    end
  end
end