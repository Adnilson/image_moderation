Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/process', to: 'receiver#create'
    end
  end
end
