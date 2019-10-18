Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # TODO add root path
  resources :authors
  resources :posts do
    resources :comments
  end
end
