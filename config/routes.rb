Rails.application.routes.draw do
  devise_for :users

  resources :users
  resources :events
  resources :attendees
  root "home#index"
end
