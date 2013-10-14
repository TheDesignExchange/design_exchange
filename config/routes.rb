DesignExchange::Application.routes.draw do
  resources :design_methods
  resources :method_categories, only: [:show]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create, :edit]
  get 'search/(:query)', controller: 'design_methods', action: 'search', as: 'search'
end
