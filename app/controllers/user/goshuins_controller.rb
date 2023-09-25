# ユーザー：御朱印関連
class User::GoshuinsController < ApplicationController

  # アクセス制限
  before_action :authenticate_user!

  # 御朱印投稿ページ
  def new
    # 空の変数作成
    @goshuin = Goshuin.new
  end

  # 御朱印投稿機能
  def create
    # フォームからのデータを使って新しい Goshuin オブジェクトを作成
    @goshuin = Goshuin.new(goshuin_params)

    # レスポンスの形式に応じて処理を分岐
    respond_to do |format|
      # データが保存された場合
      if @goshuin.save
        format.html do
          # 成功時にフラッシュメッセージを設定し、詳細ページにリダイレクト
          flash[:info] = "投稿されました"
          redirect_to place_path(@goshuin.place)  # 関連する寺社の詳細ページに遷移
        end
        format.json { render :show, status: :created, location: @goshuin }
      else
        format.html do
          # 失敗時にフラッシュメッセージを設定し、新規投稿フォームを再表示
          flash.now[:danger] = "失敗しました"
          # 新規投稿ページへ遷移
          render :new
        end
        format.json { render json: @goshuin.errors, status: :unprocessable_entity }
      end
    end
  end

  # ユーザー参拝日記（ログインしているユーザーのみ）
  def index
    page = params[:page]
    per = 5

    # ログインしているユーザーデータを格納
    @user = current_user
    # ログインしているユーザーの御朱印データを格納
    @goshuins = @user.goshuins.page(page).per(per) # ページネーションを適用（１ページ5件表示）
    # ユーザーが投稿した御朱印数を格納
    @num_of_goshuin = @user.goshuins.count
    # ユーザーが保持している御朱印についたいいねの総数を格納
    @total_likes = @user.total_likes_count
    case params[:sort_option]
      # いいねの多い順
      when 'most_liked'
        @goshuins = @goshuins.most_liked(page, per)
      # 参拝日でソート
      when 'latest_by_visit_day'
        @goshuins = @goshuins.latest_by_visit_day(page, per)
      when 'old_by_visit_day'
        @goshuins = @goshuins.old_by_visit_day(page, per)
      else
        @goshuins = @goshuins.order(created_at: :desc).page(page).per(per)
    end
    # 全てのデータを取得してふるいにかけている（推奨されていない）
    @release_goshuins = @goshuins.where(status: "release").order(created_at: :desc).page(params[:page]).per(5)
    @private_goshuins = @goshuins.where(status: "private_status").order(created_at: :desc).page(params[:page]).per(5)


  end

  # 御朱印編集ページ
  def edit
    # 特定の御朱印データを格納
    @goshuin = Goshuin.find(params[:id])
  end

  # 御朱印更新機能
  def update
    # 特定の御朱印データを格納
    @goshuin = Goshuin.find(params[:id])
    # 更新された場合
    if @goshuin.update(goshuin_params)
      # 成功メッセージ
      flash[:info] = "編集されました"
      # 関連する寺社の詳細ページに遷移
      redirect_to place_path(@goshuin[:place_id])
    # 失敗した場合
    else
      # 失敗メッセージ
      flash.now[:danger] = "失敗しました"
      # 編集ページへ遷移
      render :edit
    end
  end

  # 御朱印削除機能
  def destroy
    # 特定の御朱印詳細データを格納
    @goshuin = Goshuin.find(params[:id])
    # 削除成功した場合
    if @goshuin.destroy
      # 成功メッセージ
      redirect_to goshuins_path, info: "削除完了しました"
    # 失敗した場合
    else
      # 失敗メッセージ
      flash.now[:danger] = "削除失敗しました"
      render :index
    end
  end

  private

  def goshuin_params
    params.require(:goshuin).permit(:user_id, :place_id, :message, :price, :visit_day, :goshuin_status, :status, :image).merge(user_id: current_user.id)
  end

  def authenticate_user!
    # ユーザーがログインしていない場合、適切な処理を行う
    unless current_user
      redirect_to new_user_session_path, alert: 'ログインが必要です。'
    end
  end

end