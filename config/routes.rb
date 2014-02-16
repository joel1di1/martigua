Martigua::Application.routes.draw do
  
  resources :score_events

  resources :training_presences

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
    resources :users, only: [] do 
      member do
        match 'availability', to: 'availabilities#set', via: [:post, :patch, :put], as: 'set_availability'
      end
    end
  end

  resources :trainings, only: [:index, :show, :update] do
    resources :users, only: [] do 
      member do
        match 'availability', to: 'training_availabilities#set', via: [:post, :patch, :put], as: 'set_availability'
      end
    end
    resources :training_presences do 
      collection do 
        get 'edit', to: 'training_presences#edit_list'
      end
    end
   end

  resources :ping, only: [:index]

  resources :teams, only: [] do 
    resources :matches, only: [:index]
  end

  get 'vie_de_club', to: 'vie_de_club#index'

  scope 'coach' do
    get '/', to: 'coach_home#index', as: 'coach_home'
    get 'stats', to: 'coach_home#stats'
  end


  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)

  root 'home#index'

end
