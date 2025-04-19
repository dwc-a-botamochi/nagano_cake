Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


root :to =>"homes#top"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :public do

    #カート内商品
    resources :cart_items, only:[:index, :update, :destroy, :create] do
      collection do
        delete  'destroy_all'
      end
    end

    #注文
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'check'
        get 'thanks'
      end
    end

  end

  get 'about' => 'public/homes#about'

end
