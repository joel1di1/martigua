Martigua::Application.routes.draw do
  
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  resources :locations, only: [:index, :show]

  resources :matches, only: [:index, :show]

  resources :trainings, only: [:index, :show]

  resources :ping, only: [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)

  root 'home#index'

end
