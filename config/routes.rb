Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # TODO: landing page
  root "bookings#index"
  post "api", to: "api#info"

  resources :bookings, except: [ :edit, :show, :update ]

end
