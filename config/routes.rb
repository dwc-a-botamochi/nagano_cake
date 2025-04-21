Rails.application.routes.draw do

  root :to =>"public/homes#top"
  get 'about' => 'public/homes#about

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    get   "/customers/my_page", to: "customers#show"
    get   "/customers/information/edit", to: "customers#edit"
    patch "/customers/information", to: "customers#update"
    get   "/customers/check", to: "customers#check"
    patch "/customers/withdraw", to: "customers#withdraw"
    # カート内商品
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all', to: 'cart_items#destroy_all'
      end
    end
    #注文
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'check'
        get 'thanks'
      end
    end
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resource :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    #注文
    resources :orders, only:[:show, :update] do
      resources :order_details, only:[:update]
    end
    resources :items, except: [:destroy]
  end
end
