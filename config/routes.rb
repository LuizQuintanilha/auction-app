Rails.application.routes.draw do
  devise_for :admins
  root to: 'home#index'
  resources :products, only: [:new, :create, :show]
end
