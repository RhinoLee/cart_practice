Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'products#index'

  resources :products, only: [:index, :show]

  namespace :admin do 
    root 'products#index'
    resources :products, except: [:show]
    resources :vendors, except: [:show]
  end 


  namespace :api do 
    namespace :v1 do 
      post 'subscribe', to: 'utils#subscribe'
    end
  end
  
end
