Rails.application.routes.draw do
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: %i(edit)
  get "password_resets/new"
  get "password_resets/edit"
  resources :password_resets, except: %i(index destroy show)
end

