Rails.application.routes.draw do
  resources :submissions, only: [:show, :create]
  resources :languages, only: [:index]
end
