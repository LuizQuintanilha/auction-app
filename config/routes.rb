Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: 'home#index'
  resources :product_models, only: %i[index show]
  resources :products, only: %i[index new create show edit update]
  resources :product_batches, only: %i[index new create show edit update destroy] do
    patch :approve, :wait_approve, on: :member
    patch :close_batch, :waiting_close, on: :member
    resources :bids, only: %i[new create]
    resources :questions, only: %i[new create] do
      delete :destroy, on: :member
    end
    resources :answers, only: %i[index new create]
    get 'search', on: :collection
  end

  resources :blocked_users, only: %i[update index]
  resources :favorites, only: %i[create destroy]
  get 'user_space', to: 'product_batches#user_space'
  get 'show_result', to: 'product_batches#show_result'
  get 'expired_batches', to: 'product_batches#expired_batches'
  get 'aprove', to: 'product_batches#admin_aprove_batch'
  get 'favorite_table', to: 'favorites#favorite_table'
end
