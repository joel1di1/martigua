Martigua::Application.routes.draw do
  
  resources :availabilities do 
    collection do 
      resources :matches, only: [] do
        collection do
          post '', to: 'availabilities#bulk_change', via: [:post], as: 'bulk_availabilities'
        end
      end
    end
  end

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  resources :locations, only: [:index, :show]

  resources :matches, only: [:index, :show] 

  resources :trainings, only: [:index, :show]

  resources :ping, only: [:index]

  resources :teams, only: [] do 
    resources :matches, only: [:index]
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)

  root 'home#index'

end
