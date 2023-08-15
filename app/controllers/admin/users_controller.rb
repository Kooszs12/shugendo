class Admin::UsersController < ApplicationController

  # アクセス制限
  before_action :authenticate_admin!

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @goshuins = @user.goshuins.page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

end
