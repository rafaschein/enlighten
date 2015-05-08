Rails.application.routes.draw do
  root 'projects#index'

  resources :projects
  devise_for :users
end
