#管理者：神社・仏閣コントローラー
class Admin::PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def create
  end

  def index
  end

  def show
  end

  def edit
  end

   private

  def place_params
    params.require(:place).permit(:prefecture_id, :user_id, :admin_id, :type, :name, :address, :postcode, :phone_number, :god, :sect, :goshuin_status, :pet_status)
  end

end
