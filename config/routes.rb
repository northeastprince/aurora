Rails.application.routes.draw do
  root to: "home#show"

  get "sign_up", to: "sign_ups#new"
  resource :sign_up, only: [:create] do
    resource :confirmation, only: [:show]
  end
end
