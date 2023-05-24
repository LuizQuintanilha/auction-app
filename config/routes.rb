Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: 'home#index'
  resources :products, only: [:index, :new, :create, :show, :edit, :update]
  resources :product_batches, only: [ :index, :new, :create, :show, :edit, :update, :destroy ] do
    patch :approve, :wait_approve, on: :member
    patch :close_batch, :waiting_close, on: :member
    resources :bids, only: [ :new, :create ]
    resources :questions
    resources :answers, only: [:index, :create, :new ]
    get 'search', on: :collection
  end
  
  


  #resources :answers
  
  get 'user_space', to: 'product_batches#user_space'
  get 'show_result', to: 'product_batches#show_result'
  get 'expired_batches', to: 'product_batches#expired_batches'
  get 'aprove', to: 'product_batches#admin_aprove_batch'
end
