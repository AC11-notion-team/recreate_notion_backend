Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create show update destroy] do
        collection do
          get :email_present
          post :login
          get :email_confirmed
          get :search_user
        end
      end
      post '/auth/third_party_login', to: 'authentication#third_party_login'

      resources :blocks, only: %i[index create show update destroy]
      resources :pages, only: %i[create index show update destroy] do
        post :save_data
        put  :set_current_page
        put :share
        put :editable
        resources :blocks, only: [:index]
        collection do
          delete '/delete_data', to: 'pages#delete_data'
        end
      end

      get '/fetch', to: 'endpoints#fetchUrl'
      post '/uploadImageByUrl', to: 'endpoints#uploadImageByUrl'
    end
  end
end
