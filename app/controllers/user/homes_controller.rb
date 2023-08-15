class User::HomesController < ApplicationController

  def top
    @goshuins = Goshuin.page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @q = Place.ransack(params[:q])
  end

end
