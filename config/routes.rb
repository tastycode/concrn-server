Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  default_url_options host: (ENV['API_HOST'] || "http://localhost:3001")
  post '/devices', to: 'devices#create'
  post '/devices/verify', to: 'devices#verify'


  get '/tokens/validate', to: 'access_tokens#validate'
  delete '/tokens', to: 'access_tokens#destroy'
  post '/tokens/refresh', to: 'access_tokens#refresh'
  post '/tokens', to: 'access_tokens#create'

  namespace :admin do
    resources :affiliates
    resources :reports
    resources :users
    resources :zip_fences
    resources :report_events
    resources :report_notes
  end

  resources :reports, only: %i(create index show update)
  resources :dispatches, only: %i(update create)
end
