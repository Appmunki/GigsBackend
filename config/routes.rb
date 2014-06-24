GigBackend::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config


  devise_for :users
  ActiveAdmin.routes(self)
    namespace :api do
        namespace :v1 do
            devise_scope :user do
                post 'registrations' => 'registrations#create', :as => 'register'
                post 'sessions' => 'sessions#create', :as => 'login'
                delete 'sessions' => 'sessions#destroy', :as => 'logout'
            end
                  
            get 'gigs' => 'gigs#index', :as => 'gigs'
            get 'gigs/:id' => 'gigs#show'        
            post 'gigs' => 'gigs#create', :as => 'gigs'
            

            resources :payment

            post 'employer/assign' => 'gigs#assign', :as => 'employer/assign'

        end
    end



end
