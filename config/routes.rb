Rails.application.routes.draw do

  comfy_route :cms_admin, :path => '/cms'

  mount_devise_token_auth_for 'User', at: '/auth', controllers: {
    token_validations:  'token_validations'
  }

  namespace :api do
    get 'organizations/availability', to: 'organizations#availability'
    get 'locations/countries', to: 'locations#countries'
    get 'locations/countries/:country', to: 'locations#regions'
    resources :organizations, defaults: { format: 'json' } do
      resources :departaments, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
      resource :guest_user, defaults: { format: 'json' }
    end

    resources :users, defaults: { format: 'json' } do
      post 'upload'
    end

    resources :inputs, only: [:index, :show, :create, :update, :destroy], defaults: { format: 'json' }
  end

  devise_for :admins, skip: [:passwords, :registrations], path: '/admin'


  constraints subdomain: 'admin' do
    namespace :admin do
      root :to => "clients#index"

      resources :clients, only: [:index] do
        get '/become' => 'clients#become'
      end
      resources :emails, only: [:index, :edit, :update]
    end
  end

  get '/signup' => 'welcome#index'
  get '/signin' => 'welcome#index'

  constraints Subdomain do
    get '/signin' => 'welcome#index'
    get '/profile' => 'welcome#index'
    get '/teams' => 'welcome#index'
    get '/users' => 'welcome#index'
    get '/users/new' => 'welcome#index'
    get '/users/:id/edit' => 'welcome#index'
    get '/leaderboard' => 'welcome#index'
    get '/input' => 'welcome#index'
    get '/records' => 'welcome#index'
    get '/boardlogin/settings' => 'welcome#index'
    get '/password/edit' => 'welcome#index'
    get '/' => 'welcome#index'
    get '*path' => 'welcome#index'
  end

  root :to => "comfy/cms/content#show"
  comfy_route :cms, :path => '/', :sitemap => false
end
