Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks do
  post :update_row_order, on: :collection
end
end
