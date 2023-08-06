Rails.application.routes.draw do

  namespace :user do
    get 'homes/top'
  end
  namespace :admin do
    get 'homes/top'
  end
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end