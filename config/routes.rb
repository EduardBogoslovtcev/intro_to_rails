Rails.application.routes.draw do
  root "recipes#index"

  get "/about", to: "pages#about"

  resources :recipes, only: [:index, :show]
  resources :users, only: [:index, :show]
  resources :ingredients, only: [:index, :show]
end