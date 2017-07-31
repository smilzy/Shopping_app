Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  
  get 'admin', to: 'admin#index'
  
  # controller :sessions do
  #   get 'login' => :new
  #   post 'login' => :create
  #   delete 'logout' => :destroy
  # end

  # get 'sessions/new'

  # get 'sessions/create'

  # get 'sessions/destroy'

  # resources :users
  resources :orders
  resources :line_items do
    post 'decrement', on: :member
  end
 
  resources :carts do
    patch 'update_delivery', on: :member
  end
  root 'store#index', as: 'store_index'
  get 'smartphones', to: 'store#smartphones'

  resources :products do
    get :who_bought, on: :member
  end
  resources :charges
  resources :deliveries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
