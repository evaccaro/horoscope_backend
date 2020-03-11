Rails.application.routes.draw do
  post '/login', to: "auth#create"
  get '/current_user', to: "auth#show"

  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :horoscopes, only: %i(index show create)
      resources :star_signs, only: %i(index create)
      resources :users, only: %i(index show new create)
      get '/today', to: "horoscopes#showToday"
    end
  end
end
