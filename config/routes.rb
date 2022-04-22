Rails.application.routes.draw do
  resources :microgrid

  get "graphs", to: "microgrid#graphs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "index"
end
