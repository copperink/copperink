
# Koala Configuration for Facebook API Access

Koala.configure do |config|
  config.app_id           = ENV["COPPERINK_FACEBOOK_APP_ID"]
  config.app_secret       = ENV["COPPERINK_FACEBOOK_APP_SECRET"]

  # config.access_token     = ENV["COPPERINK_FACEBOOK_ACCESS_TOKEN"]
  # config.app_access_token = ENV["COPPERINK_FACEBOOK_APP_ACCESS_TOKEN"]
end
