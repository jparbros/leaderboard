Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/auth'


  root 'welcome#index'
  resources :organizations
  resources :users, defaults: { format: 'json' }  do
    resources :inputs, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
  end
  get '*path' => 'welcome#index'
end
