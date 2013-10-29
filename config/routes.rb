DesignExchange::Application.routes.draw do
  devise_for :users

  root to: "main_pages#home"

  get :about, to: "main_pages#about"

  get :contact, to: "main_pages#contact"

  resources :design_methods
  resources :method_categories, only: [:show]
  resources :users do
    resources :design_methods, only: [:index]
  end
  get 'search/(:query)', controller: 'design_methods', action: 'search', as: 'search'
  get 'autocomplete/(:term)', controller: 'design_methods', action: 'autocomplete', as: 'autocomplete'
end
