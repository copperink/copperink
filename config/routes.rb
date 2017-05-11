Rails.application.routes.draw do

  root to: 'api/base#index'

  namespace :api, defaults: { format: :json } do
    root to: 'base#index'

    namespace :v1 do
      root to: 'base#index'

      scope :sessions do
        get  '/'              => 'sessions#index'
        post '/sign-in/'      => 'sessions#signin'
        post '/sign-up/'      => 'sessions#signup'
      end

      namespace :accounts do
        get '/'               => 'accounts#index'

        scope :facebook do
          post '/list/'       => 'facebook#list'
          post '/save/'       => 'facebook#save'
        end
      end

    end
  end


  # Setup Devise for Users without
  # any routes
  devise_for :users, skip: :all

end
