Rails.application.routes.draw do
  root to: 'pages#index'

  get 'analytics' => 'pages#analytics'
  delete 'analytics' => 'analytics#destroy'
  post 'analytics' => 'analytics#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
