Rails.application.routes.draw do
  post '/process', to: 'receiver#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
