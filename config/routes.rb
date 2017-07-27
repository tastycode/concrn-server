Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'

  namespace :api do
    resources :reporters, only: [] do
    end

    resources :devices, only: [:create] do
      collection do
        get 'validate'
        post 'verify'
      end
    end

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
