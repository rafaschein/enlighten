Rails.application.routes.draw do
  root 'projects#index'

  resources :projects
  resources :people
  resources :clients
  resources :technologies
  devise_for :users
end
