Rails.application.routes.draw do
  #users
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show, :update, :destroy] do 
        member do 
          get :confirm_email
        end
      end
      post '/auth/login', to: 'authentication#login'
      
      resources :blocks, only: [:index, :create, :show, :update, :destroy]  
      resources :pages, only: [:create, :index, :show, :update, :destroy] do
        resources :blocks, only: [:index]
      end
    end
  end  
end
