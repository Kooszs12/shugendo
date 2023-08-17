class User::HomesController < ApplicationController

  def top
    # 公開された御朱印のデータを取得し、ページネーションを適用（１ページ１０件表示）
    @goshuins = Goshuin.where(status: "release").order(created_at: :desc).page(params[:page]).per(10)
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
  end

end
