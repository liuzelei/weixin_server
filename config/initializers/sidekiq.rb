require 'sidekiq/middleware/i18n'

Sidekiq.configure_server do |config|
  config.redis = {:namespace => 'weixin_server' }
end

Sidekiq.configure_client do |config|
  config.redis = {:namespace => 'weixin_server' }
end
