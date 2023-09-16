# ユーザー情報関連
class User::UsersController < ApplicationController

  # アクセス制限をかけて、exceptで一部許可させる
  before_action :authenticate_user!, except: [:show, :index]
  # アクセス制限を特定のページでだけつける（only）
  # 退会したユーザーの詳細ページを閲覧できなくさせるアクセス制限
  before_action :deleted_user_check, only: [:show]
  # ゲストユーザーにアクセス制限
  before_action :guest_user_check, only: [:edit, :update]

  # いいねをつけた投稿一覧表示
  def index
    @user = User.find(params[:id])
    @goshuins = Goshuin.joins(:favorites).where(favorites: { user_id: @user.id }).page(params[:page]).per(5)
  end

  # ユーザーマイページ。誰でも閲覧可能
  def show
    page = params[:page]
    per = 5
    # 公開された御朱印のデータを取得し、ページネーションを適用（１ページ5件表示）
    @goshuins = @user.goshuins.where(status: "release").page(page).per(per)
    # ユーザーが所持している御朱印についたいいねの総数を格納
    @total_likes = @user.total_likes_count
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }

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

  # プロフィール編集
  def edit
    @user = current_user
    @total_likes = @user.total_likes_count
  end

  # プロフィール更新
  def update
    # ログインしているユーザー本人のデータを格納
    @user = current_user
    # 更新されたら
    if @user.update(user_params)
      # 本人のマイページへ戻る
      redirect_to users_mypage_path(@user), info: "編集されました"
    else
      # 警告メッセージ
      flash.now[:danger] = "失敗しました"
      # 本人のプロフィール編集ページへ戻る
      render :edit
    end
  end

  # 退会確認
  def confirm_withdraw
    # ログインしているユーザー本人のデータ
    @user = current_user
  end

  # 退会
  def withdraw
    # ログインしているユーザー本人のデータ
    @user = current_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    # 成功メッセージ
    redirect_to root_path, info: "ご利用ありがとうございました"
  end

  private

  def user_params
    params.require(:user).permit(:id, :gohuin_id, :nickname, :email, :introduction, :image)
  end

  def deleted_user_check
    @user = User.find_by(id: params[:id])
    redirect_to root_path if !@user || @user&.is_deleted?
  end

  def guest_user_check
    redirect_to root_path if current_user.guest_user?
  end
end
