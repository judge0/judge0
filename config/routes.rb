Rails.application.routes.draw do
  root 'home#docs'
  resources :submissions, only: [:show, :create], param: :token
  resources :languages, only: [:index]
  resources :statuses, only: [:index]
  get 'system_info', to: 'application#system_info'
  get 'default_config', to: 'application#default_config'
end
