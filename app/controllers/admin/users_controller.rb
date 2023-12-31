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
    page = params[:page]
    per = 5
    # 特定ユーザー情報格納
    @user = User.find(params[:id])
    # 特定ユーザーの関連付けられた御朱印情報を格納
    @goshuins = @user.goshuins.page(params[:page]).per(5) # ページネーションを適用（１ページ5件表示）
    # ユーザーが投稿した御朱印数を格納
    @num_of_goshuin = @user.goshuins.count
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }
    # 特定のユーザーが保持している御朱印についたいいねの総数を格納
    @total_likes = @user.total_likes_count
    # ソート条件に基づいてソートされた場所を返す
    case params[:sort_option]
      when 'latest'
        @goshuins = @goshuins.latest(page, per)
      when 'old'
        @goshuins = @goshuins.old(page, per)
      # いいねの多い順
      when 'most_liked'
        @goshuins = @goshuins.most_liked(page, per)
      else
        @goshuins = @goshuins.order(created_at: :desc).page(page).per(per)
    end
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
      redirect_to admin_user_path(@user), info: "編集されました"
    else
      # 警告メッセージ
      flash.now[:danger] = "失敗しました"
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
    redirect_to admin_users_path, info: "退会処理を実行いたしました"
  end

  def user_params
    params.require(:user).permit(:id, :gohuin_id, :nickname, :email, :introduction, :image)
  end

end
