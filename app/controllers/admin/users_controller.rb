# admin/userのコントローラー
class Admin::UsersController < ApplicationController

  # アクセス制限
  before_action :authenticate_admin!

  # ユーザー一覧
  def index
    # ユーザー情報を全て格納
    @users = User.all
  end

  # ユーザー詳細
  def show
    # 特定ユーザー情報格納
    @user = User.find(params[:id])
    # 特定ユーザーの関連付けられた御朱印情報を格納
    @goshuins = @user.goshuins.page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }
    # 特定のユーザーが保持している御朱印についたいいねの総数を格納
    @total_likes = @user.total_likes_count
  end

  # ユーザー編集
  def edit
    # 特定ユーザーの情報格納
    @user = User.find(params[:id])
    # 特定のユーザーが保持している御朱印についたいいねの総数を格納
    @total_likes = @user.total_likes_count
  end

  # ユーザー情報更新
  def update
    # 特定ユーザーの情報を格納
    @user = User.find(params[:id]) # URLからユーザーIDを取得してユーザー情報を取得
    # ユーザー情報が更新される時
    if @user.update(user_params)
      # 管理者向けの詳細ページに戻る
      redirect_to admin_user_path(@user)
      # 成功メッセージ
      flash[:notice] = "編集されました"
    else
      # 警告メッセージ
      flash.now[:alert] = "失敗しました"
      # 失敗したらユーザー編集ページへ戻る
      render :edit
    end
  end

  # ユーザー退会と有効
  def destroy
    # 特定ユーザーの情報を格納
    @user = User.find(params[:id])
    # is_deletedカラムを!@userで反転させてturu(退会)時はfalse（有効）に変更。falseの時はturuに変更
    @user.update(is_deleted: !@user.is_deleted)
    # 成功メッセージ
    flash[:notice] = "退会処理を実行いたしました"
    # ユーザー一覧ページに戻る
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit(:id, :gohuin_id, :nickname, :email, :introduction)
  end

end
