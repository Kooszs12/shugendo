# ユーザー情報関連
class User::UsersController < ApplicationController

  # アクセス制限をかけて、exceptで一部許可させる
  before_action :authenticate_user!, except: [:show]

  # ユーザーマイページ。誰でも閲覧可能
  def show
    @user = User.find(params[:id])

    # 公開された御朱印のデータを取得し、ページネーションを適用（１ページ１０件表示）
    @goshuins = @user.goshuins.where(status: "release").order(created_at: :desc).page(params[:page]).per(10)

    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }
  end

  # プロフィール編集
  def edit
    @user = current_user
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

  private

  def user_params
    params.require(:user).permit(:id, :gohuin_id, :nickname, :email)
  end

end
