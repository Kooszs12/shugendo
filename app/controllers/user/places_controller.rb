#ユーザー：神社・仏閣コントローラー
class User::PlacesController < ApplicationController

  def new
    @place = Place.new
  end

  def create
    #空の変数作成
    @place = Place.new(place_params)
    #保存が成功したら
    if @place.save
      redirect_to admin_place_path(@place)
      flash[:notice] = "投稿されました"
    #失敗したら
    else
      flash.now[:alert] = "failed"
      render :new
    end
  end

  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])
  end


  def edit
    @place = Place.find(params[:id])
  end

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
