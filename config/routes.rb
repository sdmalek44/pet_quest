Rails.application.routes.draw do
  root to: 'home#index'
  get "/auth/:provider/callback", to: "sessions#create"
  get "/oauth", to: "oauth#create", as: 'oauth'
  get "/blah", to: "sessions#index", as: 'blah'
  get "/logout", to: "sessions#destroy"
end
