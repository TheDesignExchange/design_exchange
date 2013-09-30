DesignExchange::Application.routes.draw do
  resources :design_methods
  resources :method_categories, only: [:show]
  get 'search/(:query)', controller: 'design_methods', action: 'search', as: 'search'
end
