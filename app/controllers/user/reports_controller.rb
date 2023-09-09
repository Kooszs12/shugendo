class User::ReportsController < ApplicationController

  def create
    @place = Place.find(params[:place_id])
    @repot = current_user.repots.new(place_id: @place.id)
    @repot.save
  end

  def destroy
    @place = Place.find(params[:place_id])
    @repot = current_user.repots.find_by(place_id: @place.id)
    @repot.destroy
  end

  private

  def favorite_params
    params.require(:repot).permit(:place_id, :user_id, :states)
  end

end
