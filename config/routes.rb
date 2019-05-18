Rails.application.routes.draw do
  resources :users, except: [:new, :create] do
    member do
      get "confirm"
      get "confirmation"
    end
  end

  get "/sign-up", to: "users#new", as: "sign_up"
  post "/sign-up", to: "users#create"
end
