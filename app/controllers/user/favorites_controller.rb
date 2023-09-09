class User::FavoritesController < ApplicationController

  def create
    @goshuin = Goshuin.find(params[:goshuin_id])
    @favorite = current_user.favorites.new(goshuin_id: @goshuin.id) # @を追加
    @favorite.save
  end

  def destroy
    @goshuin = Goshuin.find(params[:goshuin_id])
    @favorite = current_user.favorites.find_by(goshuin_id: @goshuin.id) # @を追加
    @favorite.destroy
  end

  private

  def favorite_params
    params.require(:favorite).permit(:goshuin_id)
  end

end
