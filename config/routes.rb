Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'line/webhook', controller: 'line_webhook', action: 'create'
  resources :messages, only: [:index, :new, :create]
end
