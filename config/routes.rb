Rails.application.routes.draw do
  get 'articles/toggle/:id', to: 'articles#toggle'

  resources :articles
  resources :categories
  root 'categories#index'
end
