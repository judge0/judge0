Rails.application.routes.draw do
  root 'home#docs'

  resources :submissions, only: [:index, :show, :create, :destroy], param: :token

  resources :languages, only: [:index, :show] do
    get 'all', to: 'languages#all', on: :collection
  end

  resources :statuses, only: [:index]

  get 'system_info', to: 'info#system_info'
  get 'config_info', to: 'info#config_info'

  get 'isolate', to: 'info#isolate'

  get 'about', to: 'info#about'
  get 'version', to: 'info#version'
  get 'license', to: 'info#license'

  post 'authenticate', to: 'sessions#authenticate'
  post 'authorize', to: 'sessions#authorize'

  get 'workers', to: 'health#workers'
end
