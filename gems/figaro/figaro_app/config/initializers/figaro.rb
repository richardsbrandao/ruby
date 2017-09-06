#required_keys = ['RAILS_MAX_THREADS', 'ABC']
#/home/vagrant/.rvm/gems/ruby-2.4.0/gems/figaro-1.1.1/lib/figaro.rb:28:in `require_keys': Missing required configuration keys: ["ABC"] (Figaro::MissingKeys)
required_keys = ['RAILS_MAX_THREADS']

required_keys.merge!('PORT', 'SECRET_KEY_BASE') if Rails.env == 'production'

Figaro.require_keys(required_keys)
