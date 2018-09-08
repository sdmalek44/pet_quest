Rails.application.routes.draw do
  root to: 'home#index'
  get "/auth/:provider/callback", to: "sessions#create"
  get "/login", to: "oauth#create"
  get "/logout", to: "sessions#destroy"
  get "/search", to: "search#index"

  namespace :search do
    resources :dogs, only: [:index, :create]
  end
end
