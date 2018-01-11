Rails.application.routes.draw do
  resources :horoscopes
  resources :star_signs
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
