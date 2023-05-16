Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: 'home#index'
  resources :products, only: [:index, :new, :create, :show, :edit, :update]
  resources :product_batches, only: [ :index, :new, :create, :show, :edit, :update, :destroy ] do
    patch :approve, :wait_approve, on: :member
    get :show_result
    resources :bids, only: [ :new, :create ] 
  end
  
  get 'expired_batches', to: 'product_batches#expired_batches'
  get 'aprove', to: 'product_batches#admin_aprove_batch'
end
