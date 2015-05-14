Rails.application.routes.draw do
  resource :user, only: [:create, :new, :destroy]
  resource :session, only: [:create, :new, :destroy]
end
