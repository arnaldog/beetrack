Rails.application.routes.draw do
  get 'home/show'

  get '/show', to: 'home#show'


  namespace :api do
    namespace :v1 do
      post 'gps', to: 'gps#create'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
