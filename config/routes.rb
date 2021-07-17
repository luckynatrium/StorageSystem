Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :storages do
    resources :deliveries, only: [:new, :create]
    get 'stocks', to: 'stocks#index'
  end
  get 'deliveries', to: 'deliveries#index'
  get "transfers/choose", to: 'transfers#choose'
  resources :transfers, only: [:index, :new, :create]
  resources :goods
end
