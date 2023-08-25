#管理者：寺社コントローラー
class Admin::PlacesController < ApplicationController

  # アクセス制限
  before_action :authenticate_admin!

  # 寺社新規投稿ページ
  def new
    # 空の変数を作成
    @place = Place.new
  end

  # 寺社新規投稿機能
  def create
    #空の変数作成
    @place = Place.new(place_params)
    #保存が成功したら
    if @place.save
      # 寺社詳細ページへ遷移
      redirect_to admin_place_path(@place)
      # 成功メッセージ
      flash[:notice] = "投稿されました"
    #失敗したら
    else
      # 失敗メッセージ
      flash.now[:alert] = "失敗しました"
      # 新規投稿ページへ遷移
      render :new
    end
  end

  # 寺社一覧ページ
  def index
    # order(updated_at: :desc)で更新日順に表示
    @places = Place.order(updated_at: :desc).page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
  end

  # 寺社詳細ページ
  def show
    # 特定の寺社データ格納
    @place = Place.find(params[:id])
    # 上記の寺社が持つ御朱印のデータを格納
    @goshuins = @place.goshuins.page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
  end

  # 編集ページ
  def edit
    # 特定の寺社のデータを格納
    @place = Place.find(params[:id])
  end

  # 更新機能
  def update
    # 特定の寺社データを格納
    @place = Place.find(params[:id])
    # 更新に成功したら
    if @place.update(place_params)
        # 更新された寺社詳細ページへ遷移
        redirect_to admin_place_path(@place)
        # 成功メッセージ
        flash[:notice] = "編集されました"
    else
      # 失敗メッセージ
      flash.now[:alert] = "失敗しました"
      # 失敗した寺社編集ページへ遷移
      render :edit
    end
  end

  # 削除機能
  def destroy
    # 特定の寺社データを格納
    @place = Place.find(params[:id])
    # 上記データを削除
    @place.destroy
    # 寺社一覧ページへ遷移
    redirect_to admin_places_path
  end

   private

  def place_params
    params.require(:place).permit(
    :prefecture_id,
    :user_id,
    :admin_id,
    :category,
    :name,
    :address,
    :postcode,
    :phone_number,
    :got,
    :sect,
    :goshuin_status,
    :pet_status,
    :image)
  end

end