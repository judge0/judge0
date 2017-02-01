Rails.application.routes.draw do
  root 'home#docs'
  resources :submissions, only: [:show, :create], param: :token
  resources :languages, only: [:index]
  resources :statuses, only: [:index]
end
