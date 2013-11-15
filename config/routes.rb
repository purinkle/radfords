Radfords::Application.routes.draw do
  resources :orders
  resources :baskets
  resources :events do
    member do
      get :delete
      delete :delete, action: :destroy
    end
  end
  resources :line_items
  resources :products do
    member { get :delete }
  end
  resources :sessions, :only => [ :new, :create, :destroy ]
  resources :suppliers, except: :show do
    member { get :delete }
  end

  root :to => 'pages#home'

  match '/outlets',  :to => 'pages#outlets'
  match '/contact',  :to => 'pages#contact'
  match '/shop', :to => 'pages#products'
  match '/signin',   :to => 'sessions#new'
  match '/signout',  :to => 'sessions#destroy'
end
