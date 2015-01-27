Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/auth', :constraints => { :subdomain => /.+/ }


  root 'welcome#index'
  resources :users do
    resources :inputs
  end
  get '*path' => 'welcome#index', :constraints => { :subdomain => /.+/ }
end
