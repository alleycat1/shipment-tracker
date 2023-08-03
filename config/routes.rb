Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  get 'donations', to: 'pages#donations'
  get 'success', to: 'pages#success'
  resources :shipments, only: [:index, :show, :new, :create, :edit, :update] do
    resources :pallets, only: [:new, :create]
    resources :scans, only: [:new, :create]
    get "qr", to: "shipments#qr"
  end

  resources :pallets, only: [:edit, :update, :destroy] do
    resources :pallet_scans, only: [:new, :create]
    get "qr", to: "pallets#qr"
  end

  resources :projects
end
