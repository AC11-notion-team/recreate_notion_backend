Rails.application.routes.draw do
  #users
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show, :update, :destroy]
      post '/auth/login', to: 'authentication#login'
      resources :blocks, only: [:index, :create, :show, :update, :destroy]  
      resources :pages, only: [:create, :index, :show, :update, :destroy] do
        resources :blocks, only: [:index]
        member do
          post :save_data
        end
      end
      
      get "/fetch", to: "endpoints#fetchUrl"
      post "/uploadImageByUrl", to: "endpoints#uploadImageByUrl"
    end
  end
end
