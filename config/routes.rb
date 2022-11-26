Rails.application.routes.draw do

  # localhost:3000/users/i
  resources :users, only: [:show] do
    # localhost:3000/users/1/items/1
    resources :items, only: [:index, :show, :create]
  end
  
  resources :items, only: [:index]
end
