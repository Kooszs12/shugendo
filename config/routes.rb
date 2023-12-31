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

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  namespace :admin do
    #検索
    get "search" => "searches#search"
     # 通報
    resources :reports, only: [:index]
    resources :places, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :goshuins, only: [:edit, :update, :destroy]
  end

  scope module: :user do
    root "homes#top"
    # マイページ
    get 'users/mypage/:id' => 'users#show', as: :users_mypage
    # いいね一覧
    get 'users/favorites/index/:id' => 'users#index', as: :users_favorites_index
    # 会員編集ページ
    get 'users/infomation/edit' => 'users#edit'
    patch '/users/information' => 'users#update'
    # 退会確認ページ
    get 'users/confirm_withdraw' => 'users#confirm_withdraw', as: :users_confirm_withdraw
    # 退会機能
    patch '/user/withdraw' => 'users#withdraw'
     #検索
    get "search" => "searches#search"
    # 寺社関連
    resources :places, only: [:new, :create, :index, :show, :edit, :update] do
      # report_urlにplace.idを持たせるためのネスト
      resource :report, only: [:create]
    end
    get "places_json" => "goshuins#places_json"
    # 御朱印関連
    resources :goshuins, only: [:new, :create, :index, :edit, :update, :destroy] do
      # いいね関連
      resource :favorites, only: [:create, :destroy]
    end
  end
end