Rails.application.routes.draw do
  root 'home#docs'

  resources :submissions, only: [:index, :show, :create], param: :token
  resources :languages,   only: [:index]
  resources :statuses,    only: [:index]

  resources :test_cases,  only: [:index, :show, :create], param: :uuid
  resources :test_suites, only: [:index, :show, :create], param: :uuid

  get 'system_info', to: 'info#system_info'
  get 'config_info', to: 'info#config_info'
  get 'version',     to: 'info#version'

  post 'authenticate', to: 'sessions#authenticate'
  post 'authorize',    to: 'sessions#authorize'

  get 'workers', to: 'health#workers'
end

