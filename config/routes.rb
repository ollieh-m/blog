Rails.application.routes.draw do
  root to: "articles#index"
  resources :articles, only: %i(index show)
end
