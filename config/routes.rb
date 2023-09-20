Rails.application.routes.draw do
  get "/merchants/:merchant_id/dashboard", to: "merchants#show", as: :merchant_dashboard
  get "/merchants/:merchant_id/items", to: "merchants/items#index", as: :merchant_items
  get "/merchants/:merchant_id/items/new", to: "merchants/items#new", as: :new_merchant_item
  post "/merchants/:merchant_id/items", to: "merchants/items#create"
  patch "/merchants/:merchant_id/items/status", to: "merchants/items#update", as: :status_merchant_item
  get "merchants/:merchant_id/items/:item_id", to: "merchants/items#show", as: :merchant_item
  get "/merchants/:merchant_id/items/:item_id/edit", to: "merchants/items#edit", as: :edit_merchant_item
  patch "/merchants/:merchant_id/items/:item_id", to: "merchants/items#update"
  get "/merchants/:merchant_id/invoices", to: "merchants/invoices#index"
  patch "/merchants/:merchant_id/invoices/:invoice_id/:item_id", to: "merchants/invoices#update", as: :merchant_invoice_item
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchants/invoices#show", as: :merchant_invoice
  get "/admin", to: "admin#index"
  
  namespace :admin do 
    resources :merchants, except: [:destroy]
    resources :invoices, only: [:index, :show, :update]
  end

  # resources :merchants, only: [:show] do
  # # namespace :merchant do
  #     resources :invoices, only: [:index, :show]
  #     resources :items, only: [:index]
  #   # end
  # end

  # resources :merchants do
  #   resources :dashboard, only: [:show]
  #   resources :items, only: [:index], controller: "merchants/items"
  #   resources :invoices, only: [:index, :show], controller: "merchants/invoices"
  # end

  # resources :merchants, param: :merchant_id do
  #   get "dashboard", on: :member, to: "merchants#show_dashboard"
  #   resources :items, only: [:index]
  #   resources :invoices, only: [:index, :show]
  # end
end
