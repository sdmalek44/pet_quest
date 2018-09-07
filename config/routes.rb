Rails.application.routes.draw do
  root to: 'home#index'
  get "/auth/google/callback", to: "sessions#create"

end
