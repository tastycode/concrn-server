if Rails.env.test? # so sorry, rspec within docker isn't picking up the encrypted secrets
  Authy.api_key = "test"
else
  Secrets.authy_key
end
Authy.api_uri = 'https://api.authy.com/'
