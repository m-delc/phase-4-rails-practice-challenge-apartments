Rails.application.routes.draw do
  resources :tenants
  resources :apartments
  resources :leases, only: [:create, :destroy, :index]
end
