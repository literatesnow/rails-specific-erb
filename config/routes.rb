Rails.application.routes.draw do
  get 'home/index'

  resources :todo_items

  root 'home#index'
end
