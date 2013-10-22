Martigua::Application.routes.draw do
  
  resources :invitations, only: [:create]

  resources :availabilities do 
    collection do 
      resources :matches, only: [] do
        collection do
          match '', to: 'availabilities#bulk_change', via: [:post, :get], as: 'bulk_availabilities'
        end
      end
    end
  end

  resources :training_availabilities do 
    collection do 
      resources :trainings, only: [] do
        collection do
          match '', to: 'training_availabilities#bulk_change', via: [:post, :get], as: 'bulk_availabilities'
        end
      end
    end
  end

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  resources :locations, only: [:index, :show]

  resources :matches, only: [:index, :show] do
    member do 
      resource :selection, only: [:update]
    end
  end

  resources :trainings, only: [:index, :show]

  resources :ping, only: [:index]

  resources :teams, only: [] do 
    resources :matches, only: [:index]
  end

  scope 'coach' do
    get '/', to: 'coach_home#index', as: 'coach_home'
  end


  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)

  root 'home#index'

end
