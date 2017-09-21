Rails.application.routes.draw do
  root 'home#docs'
  resources :submissions, only: [:show, :create], param: :token
  resources :languages, only: [:index]
  resources :statuses, only: [:index]
  get 'system_info', to: 'application#system_info'
  get 'config_info', to: 'application#config_info'
  get 'status', to: 'application#status'
end
