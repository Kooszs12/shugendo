class Admin::UsersController < ApplicationController

  # アクセス制限
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @goshuins = @user.goshuins.page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }
    @total_likes = @user.total_likes_count
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id]) # URLからユーザーIDを取得してユーザー情報を取得
    if @user.update(user_params)
      redirect_to admin_user_path(@user) # 管理者向けの詳細ページにリダイレクト
      flash[:notice] = "編集されました"
    else
      flash.now[:alert] = "失敗しました"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: !@user.is_deleted)
    # reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit(:id, :gohuin_id, :nickname, :email)
  end

end
