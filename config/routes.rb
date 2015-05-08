Rails.application.routes.draw do
  root 'projects#index'

  resources :projects
  resources :people
  devise_for :users
end
