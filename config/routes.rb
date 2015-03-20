Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/auth'


  root 'owner#index'
  namespace :api do
    resources :organizations do
      resources :departaments, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
    end
    resources :users, defaults: { format: 'json' }
    resources :inputs, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
  end
  get '*path' => 'owner#index'
end
