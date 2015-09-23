Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

  constraints do
    namespace :api, path: '/api' do
      namespace :v1 do
         resources :form_permissions, only: [:create, :index]
      end
    end
  end
end
