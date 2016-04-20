Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'home#index'

  # регистрация и работа со своим аккаунтом
  namespace :users do
    get  'signup' => 'registrations#new', as: :signup
    post 'signup' => 'registrations#create'

    get  'login'  => 'sessions#new',     :as => :login
    post 'login'  => 'sessions#create'
    get  'logout' => 'sessions#destroy', :as => :logout
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :countries, except: [:new, :edit] do
        resources :teams, only: [:index, :create]
      end
      resources :teams, only: [:show, :update, :destroy]
    end
  end
end
