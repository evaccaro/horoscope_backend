Rails.application.routes.draw do
  resources :horoscopes
  resources :star_signs
  resources :users
  post '/login', to: "auth#create"
  get '/current_user', to: "auth#show"
  get '/today', to: "horoscopes#showToday"
  patch '/add_favorite', to: "users#add_favorite"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
