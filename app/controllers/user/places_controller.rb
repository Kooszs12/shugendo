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

  # 寺社一覧
  def index
    @places = Place.all
  end

  # 寺社詳細ページ（関連した御朱印の表示）
  def show
    @place = Place.find(params[:id])
    @goshuins = @place.goshuins.page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
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
        redirect_to admin_place_path(@place)
        flash[:notice] = "編集されました"
    else
      flash.now[:alert] = "failed"
      render :edit
    end
  end

   private

  def place_params
    params.require(:place).permit(:prefecture_id, :user_id, :admin_id, :category, :name, :address, :postcode, :phone_number, :got, :sect, :goshuin_status, :pet_status, :image)
  end

end
