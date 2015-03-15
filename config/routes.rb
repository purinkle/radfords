Radfords::Application.routes.draw do
  resource :basket

  resources :orders
  resources :events do
    member do
      get :delete
      delete :delete, action: :destroy
    end
  end
  resources :fulfilments, only: :create
  resources :line_items
  resources :products do
    member { get :delete }
  end
  resources :sessions, :only => [ :new, :create, :destroy ]
  resources :suppliers, except: :show do
    member { get :delete }
  end

  root :to => 'pages#home'

  get '/outlets',  :to => 'pages#outlets'
  get '/contact',  :to => 'pages#contact'
  get '/shop', :to => 'pages#products'
  get '/signin',   :to => 'sessions#new'
  get '/signout',  :to => 'sessions#destroy'
end
