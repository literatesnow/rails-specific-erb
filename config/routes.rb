Rails.application.routes.draw do
  #get 'home/index'

  resources :todo_items

  root 'todo_items#index'
end
