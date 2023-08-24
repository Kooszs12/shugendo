# ユーザー情報関連
class User::UsersController < ApplicationController

  # アクセス制限をかけて、exceptで一部許可させる
  before_action :authenticate_user!, except: [:show]
  before_action :deleted_user_check, only: [:show]
  before_action :guest_user_check, only: [:edit, :update]

  # ユーザーマイページ。誰でも閲覧可能
  def show
    # 公開された御朱印のデータを取得し、ページネーションを適用（１ページ１０件表示）
    @goshuins = @user.goshuins.where(status: "release").order(created_at: :desc).page(params[:page]).per(10)
    @total_likes = @user.total_likes_count
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }
  end

  # プロフィール編集
  def edit
    @user = current_user
    @total_likes = @user.total_likes_count
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path(@user)
      flash[:notice] = "編集されました"
    else
      flash.now[:alert] = "失敗しました"
      render :edit
    end
  end

  def confirm_withdraw
    @user = User.find(current_user.id)
  end

  def withdraw
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:id, :gohuin_id, :nickname, :email, :introduction)
  end

  def deleted_user_check
    @user = User.find_by(id: params[:id])
    redirect_to root_path if !@user || @user&.is_deleted?
  end

  def guest_user_check
    redirect_to root_path if current_user.guest_user?
  end
end
