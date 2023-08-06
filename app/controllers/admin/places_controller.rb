#管理者：神社・仏閣コントローラー
class Admin::PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def create
    #空の変数作成
    byebug
    @place = Place.new(place_params)
    #保存が成功したら
    #byebug
    if @place.save
      flash[:notice] = "You have created book successfully."
      redirect_to place_path(@place.id)
    #失敗したら
    else
      @places = Place.all
      render :top
    end
  end

  def index
  end

  def show
  end

  def edit
  end

   private

  def place_params
    params.require(:place).permit(:prefecture_id, :user_id, :admin_id, :type, :name, :address, :postcode, :phone_number, :got, :sect, :goshuin_status, :pet_status)
  end

end
