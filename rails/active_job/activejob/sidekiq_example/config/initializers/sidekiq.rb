redis_url = 'redis://services:6379'
# 'redis://localhost:6379/5'

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, namespace: "activejob-sample" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, namespace: "activejob-sample" }
end