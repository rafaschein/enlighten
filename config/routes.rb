Rails.application.routes.draw do
  root 'projects#index'

  resources :projects
  resources :people
  resources :clients
  devise_for :users
end
