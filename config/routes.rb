Rails.application.routes.draw do
  root 'dashboard#index'

  resources :projects do
    resources :activities, path: 'activities/:type', only: [:show, :create], defaults: { owner: 'project' }
  end

  resources :people do
    resources :activities, path: 'activities/:type', only: [:show, :create], defaults: { owner: 'person' }
  end

  resources :technologies do
    resources :activities, path: 'activities/:type', only: [:show, :create], defaults: { owner: 'technology' }
  end

  resources :clients

  devise_for :users
end
