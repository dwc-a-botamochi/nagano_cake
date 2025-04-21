Rails.application.routes.draw do

  root :to =>"homes#top"

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    get   "/customers/my_page", to: "customers#show"
    get   "/customers/information/edit", to: "customers#edit"
    patch "/customers/information", to: "customers#update"
    get   "/customers/check", to: "customers#check"
    patch "/customers/withdraw", to: "customers#withdraw"

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end
end
