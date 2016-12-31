module Wallet
  class Connector
    class << self
      include Wallet::Hiei
    end
  end
end