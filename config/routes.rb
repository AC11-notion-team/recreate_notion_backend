Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create show update] do
        collection do
          get :email_present
          get :email_confirmed
          get :search_user
          get :search_page
          get :trash_page
          post :login
          post :third_party_login
          put :restore_page
        end
      end
      resource :sharepages, only: [] do
        put :invite_to_others
        delete :remove_invite
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
