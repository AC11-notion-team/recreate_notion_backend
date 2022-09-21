Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create show update] do
        collection do
          get :email_present
          get :email_confirmed
          post :login
          post :third_party_login
          get :search
        end
      end

      resources :blocks, only: %i[index create show update destroy]
      resources :pages, only: %i[create index show update destroy] do
        post :save_data
        put  :set_current_page
        put :share
        put :editable
        get :show_page_info
        delete :delete_page
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
