Rails.application.routes.draw do
  root "welcome#index"
  
  resources :graph_request, only: %i[index show create], path: :requests

  # get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
