Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

   # 会員用
  # URL /customers/sign_in ...
  devise_for :users, skip: [:passwords],controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "/" => "homes#top"
    resources :places, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end

  scope module: :user do
    root "homes#top"
    resources :places, only: [:new, :create, :index, :show, :edit, :update]
  end

end