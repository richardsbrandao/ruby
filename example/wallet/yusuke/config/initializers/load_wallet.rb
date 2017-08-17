FILE = 'config/wallet_config.yml'

WALLET_CONFIG = YAML.load_file(Rails.root.join(FILE))[Rails.env]
