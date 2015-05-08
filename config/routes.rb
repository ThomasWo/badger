Rails.application.routes.draw do
  devise_for :users

  resources :users
  resources :events do
    resources :attendees do
      collection do
        get :import
        post :import_csv
        get :export
      end
    end
  end

  root "home#index"
end
