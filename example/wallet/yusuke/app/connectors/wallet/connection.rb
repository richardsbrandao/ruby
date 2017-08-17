module Wallet
  module Connection
    include HTTParty
    format :json

    base_uri WALLET_CONFIG['url']
    headers 'Content-Type' => 'application/json'
    default_timeout WALLET_CONFIG['timeout']
  end
end