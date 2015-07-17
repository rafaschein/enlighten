Rails.application.routes.draw do
  root 'dashboard#index'

  concern :followable do
    member do
      put :follow
      put :unfollow
    end
  end

  concern :likable do
    member do
      put :like
      put :unlike
    end
  end

  resources :projects, concerns: [:followable, :likable] do
    resources :activities, path: 'activities/:type', only: [:show, :create], defaults: { owner: 'project' }
  end

  resources :people, concerns: [:followable, :likable] do
    resources :activities, path: 'activities/:type', only: [:show, :create], defaults: { owner: 'person' }
  end

  resources :technologies, concerns: [:followable, :likable] do
    resources :activities, path: 'activities/:type', only: [:show, :create], defaults: { owner: 'technology' }
  end

  resources :clients, concerns: [:followable, :likable]

  devise_for :users
end
