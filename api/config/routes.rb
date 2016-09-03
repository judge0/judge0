Rails.application.routes.draw do
  resources :languages, only: [:index]
end
