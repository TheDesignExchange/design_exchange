DesignExchange::Application.routes.draw do
  devise_for :users

  root to: "main_pages#home"

  get "main_pages/about"

  get "main_pages/contact"

  resources :design_methods
  resources :method_categories, only: [:show]
  get 'search/(:query)', controller: 'design_methods', action: 'search', as: 'search'
end
