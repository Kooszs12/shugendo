# ユーザー：御朱印関連
class User::GoshuinsController < ApplicationController

  # アクセス制限
  before_action :authenticate_user!

  # 御朱印投稿ページ
  def new
    # 空の変数作成
    @goshuin = Goshuin.new
    # 神社データ（セレクトボックスの中身）
    @jinja = Place.where(category: 0).joins(:prefecture).order(prefecture_id: :asc)
    # お寺データ（セレクトボックスの中身）
    @otera = Place.where(category: 1).joins(:prefecture).order(prefecture_id: :asc)
  end

  # 御朱印投稿機能
  def create
    # フォームからのデータを使って新しい Goshuin オブジェクトを作成
    @goshuin = Goshuin.new(goshuin_params)
    # 神社データの取得（category: 0 でフィルタリング）
    @jinja = Place.where(category: 0)
    # お寺データの取得（category: 1 でフィルタリング）
    @otera = Place.where(category: 1)

    # レスポンスの形式に応じて処理を分岐
    respond_to do |format|
      # データが保存された場合
      if @goshuin.save
        format.html do
          # 成功時にフラッシュメッセージを設定し、詳細ページにリダイレクト
          flash[:notice] = "投稿されました"
          redirect_to place_path(@goshuin.place)  # 関連する寺社の詳細ページに遷移
        end
        format.json { render :show, status: :created, location: @goshuin }
      else
        format.html do
          # 失敗時にフラッシュメッセージを設定し、新規投稿フォームを再表示
          flash.now[:alert] = "失敗しました"
          # 新規投稿ページへ遷移
          render :new
        end
        format.json { render json: @goshuin.errors, status: :unprocessable_entity }
      end
    end
  end

  # ユーザー参拝日記（ログインしているユーザーのみ）
  def index
    # ログインしているユーザーデータを角の
    @user = current_user
    # ログインしているユーザーの御朱印データを格納
    @goshuins = @user.goshuins.page(params[:page]).per(5) # ページネーションを適用（１ページ5件表示）
    # ユーザーが保持している御朱印についたいいねの総数を格納
    @total_likes = @user.total_likes_count
  end

  # 御朱印編集ページ
  def edit
    # 特定の御朱印データを格納
    @goshuin = Goshuin.find(params[:id])
    # 上記の御朱印に関連付いたplaceモデルに存在するcategoryカラムを格納
    @category = @goshuin.place.category
    # 神社データ（セレクトボックスの中身）
    @jinja = Place.where(category: 0).joins(:prefecture).order(prefecture_id: :asc)
    # お寺データの（セレクトボックスの中身）
    @otera = Place.where(category: 1).joins(:prefecture).order(prefecture_id: :asc)
  end

  # 御朱印更新機能
  def update
    # 特定の御朱印データを格納
    @goshuin = Goshuin.find(params[:id])
     # 神社データ（セレクトボックスの中身）
    @jinja = Place.where(category: 0)
    @otera = Place.where(category: 1)

    # 更新された場合
    if @goshuin.update(goshuin_params)
      # 成功メッセージ
      flash[:notice] = "編集されました"
      # 関連する寺社の詳細ページに遷移
      redirect_to place_path(@goshuin[:place_id])
    # 失敗した場合
    else
      # 失敗メッセージ
      flash.now[:alert] = "失敗しました"
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
      redirect_to goshuins_path, notice: "削除完了しました"
    # 失敗した場合
    else
      # 失敗メッセージ
      flash.now[:alert] = "削除失敗しました"
      render :index
    end
  end

  def places_json
    if params[:cat] == "shrine"
      places = Place.joins(:prefecture).where(category: 0, prefecture_id: params[:pref]) # 神社
    else
      places = Place.joins(:prefecture).where(category: 1, prefecture_id: params[:pref]) # お寺
    end
    render json: places
  end

  private

  def goshuin_params
    if params.require(:goshuin)[:category] == 'temple'
      params.require(:goshuin)[:place_id] = params[:place_id2]
    end

    params.require(:goshuin).permit(:user_id, :place_id, :place_id2, :category, :message, :price, :visit_day, :goshuin_status, :status, :image).merge(user_id: current_user.id)
  end

end