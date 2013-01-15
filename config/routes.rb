SpineRails3::Application.routes.draw do
  resources :posts
  resources :pages
  resources :instances
  resources :projects
  root :to => 'projects#index'
end
