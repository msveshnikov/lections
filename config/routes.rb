Rails.application.routes.draw do
  get 'articles/toggle/:id', to: 'articles#toggle'

  resources :articles
  resources :categories
  root 'categories#index'
  resources :ratings, only: [:update, :show]
  resources :searches

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
