Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/devices', to: 'devices#create'
  post '/devices/verify', to: 'devices#verify'


  get '/tokens/validate', to: 'access_tokens#validate'
  delete '/tokens', to: 'access_tokens#destroy'
  post '/tokens/refresh', to: 'access_tokens#refresh'

  resources :reports, only: %i(create index)
end
