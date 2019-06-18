Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
  ENV["MOM_API_KEY"],
  ENV["MOM_API_SECRET"]
end