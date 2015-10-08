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

        resources :subscribers do
          collection do
            post 'validate_email', to: 'subscribers#validate_email'
            post 'validate_email_uniqueness', to: 'subscribers#validate_email_uniqueness'
          end
        end

        resource :versions, only: :none do
          collection do
            post 'undo', to: 'versions#undo'
          end
        end

      end
    end
  end
end
