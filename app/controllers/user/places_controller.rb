#ユーザー：寺社コントローラー
class User::PlacesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  # 寺社投稿ページ
  def new
    @place = Place.new
  end

  # 寺社投稿機能
  def create
    #空の変数作成
    @place = Place.new(place_params)
    #保存が成功したら
    if @place.save
      redirect_to place_path(@place)
      flash[:notice] = "投稿されました"
    #失敗したら
    else
      flash.now[:alert] = "failed"
      render :new
    end
  end

  def index
    if params[:prefecture_id]
      @places = Place.where(prefecture_id: params[:prefecture_id]).page(params[:page]).per(10)
    elsif params[:area_id]
      @places = Place.joins(:prefecture).where(prefecture: {area_id: params[:area_id]})
                      .order(prefecture_id: :asc).page(params[:page]).per(10)
    else
    # 都道府県順に表示させる
      @places = Place.joins(:prefecture).order(prefecture_id: :asc).page(params[:page]).per(10)
    end
  end

  # 寺社詳細ページ（関連した御朱印の表示）
  def show
    @place = Place.find(params[:id])
    # 公開された御朱印のデータを取得し、ページネーションを適用（１ページ１０件表示）
    @goshuins = @place.goshuins.where(status: "release").order(created_at: :desc).page(params[:page]).per(10)
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }
  end

  # 寺社編集ページ（誰がいつ編集したのか履歴を残したい）
  def edit
    @place = Place.find(params[:id])
  end

  # 寺社編集機能
  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
        redirect_to place_path(@place)
        flash[:notice] = "更新されました"
    else
      flash.now[:alert] = "失敗しました"
      render :edit
    end
  end

   private

  def place_params
    params.require(:place).permit(
      :prefecture_id,
      :category,
      :name,
      :address,
      :postcode,
      :phone_number,
      :got,
      :sect,
      :goshuin_status,
      :pet_status,
      :image,
      :fee,
      :start_time,
      :end_time
      ).merge(
        user_id: user_signed_in? ? current_user.id : nil,
        admin_id: admin_signed_in? ? current_admin.id : nil
      )
  end

end
