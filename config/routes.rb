Rails.application.routes.draw do
  root to: 'home#index'
  get "/auth/:provider/callback", to: "sessions#create"
  get "/login", to: "oauth#create"
  get "/logout", to: "sessions#destroy"
  get "/search", to: "search#index"

  namespace :search do
    resources :dogs, only: [:index, :show]
    resources :cats, only: [:index, :show]
  end

  namespace :default do
    resources :favorites, only: [:create]
  end
end
