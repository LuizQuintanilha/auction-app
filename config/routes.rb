Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: 'home#index'
  resources :products, only: [:index, :new, :create, :show, :edit, :update]


  resources :product_batches, only: [:index, :new, :create, :show, :edit, :update] do
    patch :approve, :wait_approve, on: :member
    resources :bids do
      post :create, on: :member
    end
  end

  get 'aprove', to: 'product_batches#admin_aprove_batch'
end
