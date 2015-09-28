Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

  constraints do
    namespace :api, path: '/api' do
      namespace :v1 do
        resources :email_lists
      end
    end
  end
end
