Rails.application.routes.draw do
  root to: "home#show"

  scope module: "api" do
    resources :users, only: [:create]
  end
end
