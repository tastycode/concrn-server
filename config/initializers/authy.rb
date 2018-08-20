p "config/initializers/authy.rb"
Authy.api_key = Secrets.authy_key
p "Secrets.authy_key", Secrets.authy_key
p "Authy.api_key", Authy.api_key
Authy.api_uri = 'https://api.authy.com/'
