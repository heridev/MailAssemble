Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

  constraints do
    namespace :api, path: '/api' do
      namespace :v1 do
        resources :email_lists do
          collection do
            post 'subscribe/:email_uuid', to: 'email_lists#add_public_subscriber'
          end
        end
      end
    end
  end
end
