Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'home#index'

  # регистрация и работа со своим аккаунтом
  namespace :users do
    get  'registration' => 'registrations#new', as: :registration
    post 'registration' => 'registrations#create'

    get  'login'  => 'sessions#new',     :as => :login
    post 'login'  => 'sessions#create'
    get  'logout' => 'sessions#destroy', :as => :logout
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :countries, except: [:new, :edit] do
        resources :athletes, only: [:index, :create]
        resources :teams, only: [:index, :create]
        resources :sports, only: [:show], controller: 'countries_sports'
      end
      resources :athletes, only: [:show, :update, :destroy]
      resources :teams, only: [:show, :update, :destroy]

      resources :sports, except: [:new, :edit] do
        resources :disciplines, only: [:index, :create]
      end
      resources :disciplines, only: [:show, :update, :destroy] do
        resources :teams, only: [:index], controller: 'disciplines_teams'
        resources :contests, only: [:index, :create]
      end
      resources :contests, only: [:show, :update, :destroy]

      resources :locations, except: [:new, :edit]
      resources :events, except: [:new, :edit]
    end
  end
end
