class User::HomesController < ApplicationController

  def top
    @goshuins = Goshuin.page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    # 検索フォームから送信されたクエリを使って検索
    @q = Place.ransack(params[:q])
    @places = @q.result(distinct: true).page(params[:page]).per(10)
  end

end
