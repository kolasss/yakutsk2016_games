Rails.application.routes.draw do

  root to: 'home#index'

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
      resources :contests, only: [:show, :update, :destroy] do
        member do
          put :append_child
          put :prepend_child
        end
      end

      resources :locations, except: [:new, :edit]
      resources :events, except: [:new, :edit]

      resources :users, except: [:new, :edit] do
        collection do
          post :signin
          delete :signout
        end
      end

      resources :bulletins, except: [:new, :edit, :show]
      resources :results, only: [:index]
    end
  end
end
