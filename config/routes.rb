Rails.application.routes.draw do
  devise_for :users


  root to: 'api/base#index'

  namespace :api, defaults: { format: :json } do
    root to: 'base#index'

    namespace :v1 do
      root to: 'base#index'
    end
  end
end
