Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  mount ActionCable.server => '/cable'

  namespace :api do
    resources :reports, only: [:create, :show, :index] do
      resources :messages, only: [:index, :create]
      #member do
        #get 'messages'
      #end
    end

    resources :responders, only: [] do
      collection do
        get 'device'
      end
      member do
        post 'status'
      end
    end


    resources :reporters, only: [] do
    end

    resources :devices, only: [:create] do
      collection do
        post 'validate'
        post 'verify'
      end
    end

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
