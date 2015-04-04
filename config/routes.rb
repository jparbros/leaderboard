Rails.application.routes.draw do
  comfy_route :cms_admin, :path => '/admin'


  mount_devise_token_auth_for 'User', at: '/auth'

  namespace :api do
    get 'organizations/availability', to: 'organizations#availability'
    resources :organizations do
      resources :departaments, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
    end
    resources :users, defaults: { format: 'json' }
    resources :inputs, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
  end

  namespace 'rankingdesk' do
    get '/signup' => 'welcome#index'
    get '/signin' => 'welcome#index'
    get '/profile' => 'welcome#index'
    get '/profile' => 'welcome#index'
    get '/teams' => 'welcome#index'
    get '/users' => 'welcome#index'
    get '/users/new' => 'welcome#index'
    get '/users/:id/edit' => 'welcome#index'
    get '/leaderboard' => 'welcome#index'
    get '/input' => 'welcome#index'
    get '/records' => 'welcome#index'
    get '/boardlogin/settings' => 'welcome#index'
    get '*path' => 'welcome#index'
    root to: 'welcome#index'
  end

  root :to => "comfy/cms/content#show"
  comfy_route :cms, :path => '/', :sitemap => false
end
