Rails.application.routes.draw do
  root 'dashboard#index'

  resources :projects
  resources :people
  resources :clients
  resources :technologies
  devise_for :users
end
