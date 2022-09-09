Rails.application.routes.draw do
  #users
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show, :update, :destroy] do 
        collection do 
          get :email_present
          post :login
          get :email_confirmed
        end
      end
      post '/auth/third_party_login', to: 'authentication#third_party_login'
      post '/auth/login', to: 'authentication#login'
      resources :blocks, only: [:index, :create, :show, :update, :destroy]  
      resources :pages, only: [:create, :index, :show, :update, :destroy] do
        resources :blocks, only: [:index]
        collection do 
          delete "/delete_data", to: 'pages#delete_data'
        end
        member do
          post :save_data
          put :share 
          put :editable
        end
      end
      
      get "/fetch", to: "endpoints#fetchUrl"
      post "/uploadImageByUrl", to: "endpoints#uploadImageByUrl"
    end
  end
end

