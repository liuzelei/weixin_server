if Rails.env.production?
  CarrierWave.configure do |config|
    config.asset_host = "http://testweixin.bbtang.com"
  end
else
end
