Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
  Rails.application.credentials.mom[:api_key],
  Rails.application.credentials.mom[:api_secret]
end