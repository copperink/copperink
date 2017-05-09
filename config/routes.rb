Rails.application.routes.draw do

  root to: 'api/base#index'

  namespace :api, defaults: { format: :json } do
    root to: 'base#index'

    namespace :v1 do
      root to: 'base#index'

      scope :sessions do
        match '/'             => 'sessions#index',          via: :GET
        match '/sign-in/'     => 'sessions#signin',         via: :POST
        match '/sign-up/'     => 'sessions#signup',         via: :POST
      end
    end
  end


  # Devise Setup for Users
  devise_for :users, skip: :all

end
