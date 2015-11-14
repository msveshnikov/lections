Rails.application.routes.draw do
  resources :articles
  resources :categories
  root 'categories#index'
end
