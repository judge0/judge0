Rails.application.routes.draw do
  root 'home#docs'

  resources :submissions, only: [:index, :show, :create], param: :uuid
  resources :languages,   only: [:index]
  resources :statuses,    only: [:index]

  resources :test_cases,  only: [:index, :show, :create], param: :uuid
  resources :test_suites, only: [:index, :show, :create], param: :uuid

  resources :documents, only: [:index, :show], param: :digest

  get 'system_info', to: 'info#system_info'
  get 'config_info', to: 'info#config_info'
  get 'version',     to: 'info#version'
  get 'statistics',  to: 'info#statistics'

  post 'authenticate', to: 'sessions#authenticate'
  post 'authorize',    to: 'sessions#authorize'

  get 'workers', to: 'health#workers'
end

