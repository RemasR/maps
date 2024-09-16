Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: "home#index"

  resources :locations, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
    collection do
      post 'locations_action', to: 'locations#locations_action'
      get 'locations/get_info', to: 'locations#get_info'
    end
  end
end
