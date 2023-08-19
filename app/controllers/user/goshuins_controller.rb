# ユーザー：御朱印関連
class User::GoshuinsController < ApplicationController

  before_action :authenticate_user!

  # 御朱印投稿ページ
  def new
    @goshuin = Goshuin.new
    # 神社data
    @jinja= Place.where(category: 0)
    # お寺data
    @otera= Place.where(category: 1)
  end

  # 御朱印投稿機能
  def create
    # フォームからのデータを使って新しい Goshuin オブジェクトを作成
    @goshuin = Goshuin.new(goshuin_params)

    # もし place_id が nil の場合、params から place_id2 を取得して代入
    #if @goshuin[:place_id].nil?
      #@goshuin[:place_id] = params[:place_id2]
    #end

    # 神社データの取得（category: 0 でフィルタリング）
    @jinja = Place.where(category: 0)
    # お寺データの取得（category: 1 でフィルタリング）
    @otera = Place.where(category: 1)

    # レスポンスの形式に応じて処理を分岐
    respond_to do |format|
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
          render :new
        end
        format.json { render json: @goshuin.errors, status: :unprocessable_entity }
      end
    end
  end

  # ユーザー参拝日記（ログインしているユーザーのみ）
  def index
    @user = current_user
    @goshuins = @user.goshuins.page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
  end

  # 御朱印編集ページ
  def edit
    @goshuin = Goshuin.find(params[:id])
    @category = @goshuin.place.category
    @jinja = Place.where(category: 0) # 神社data
    @otera = Place.where(category: 1) # お寺data
  end

  # 御朱印編集機能
  def update
    @goshuin = Goshuin.find(params[:id])
    @jinja = Place.where(category: 0) # 神社data
    @otera = Place.where(category: 1) # お寺data

    if @goshuin.update(goshuin_params)
      flash[:notice] = "編集されました"
      redirect_to place_path(@goshuin[:place_id]) # 関連する寺社の詳細ページに遷移
    else
      flash.now[:alert] = "失敗しました"
      render :edit
    end
  end

  # 御朱印削除機能
  def destroy
    @goshuin = Goshuin.find(params[:id])
    if @goshuin.destroy
      redirect_to goshuins_path
      flash[:notice] = "削除完了しました。"
    else
      flash.now[:alert] = "削除失敗しました"
      render :index
    end
  end

  private

  def goshuin_params

    if params.require(:goshuin)[:category] == 'temple'
      params.require(:goshuin)[:place_id] = params[:place_id2]
    end

    params.require(:goshuin).permit(:user_id, :place_id, :place_id2, :category, :message, :price, :visit_day, :goshuin_status, :status, :image)
  end

end