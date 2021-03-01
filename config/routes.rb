Rails.application.routes.draw do
  root 'reports#index'

  namespace :api do
    namespace :v1 do
      post '/process', to: 'receiver#create'
    end
  end

  resources :reports, only: [:index, :edit, :update]
end
