Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

   # ユーザー用
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
     #検索
    get "search" => "searches#search"
    resources :places, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end

  scope module: :user do
    root "homes#top"
    # マイページ
    get 'users/mypage/:id' => 'users#show', as: :users_mypage
    # 会員編集ページ
    get 'users/infomation/edit' => 'users#edit'
    patch '/users/information' => 'users#update'
    # 退会確認ページ
    get 'users/confirm_withdraw' => 'users#confirm_withdraw'
    # 退会機能
    patch '/customers/withdraw' => 'customers#withdraw'
     #検索
    get "search" => "searches#search"
    resources :places, only: [:new, :create, :index, :show, :edit, :update]
    resources :goshuins, only: [:new, :create, :index, :edit, :update, :destroy]
  end
end