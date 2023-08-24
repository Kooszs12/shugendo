# ユーザー＆アドミンTopページ
class User::HomesController < ApplicationController

  def top
    # 公開された御朱印のデータを取得し新着順に表示、ページネーションを適用（１ページ１０件表示）
    @goshuins = Goshuin.where(status: "release").order(created_at: :desc).page(params[:page]).per(5)
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
  end

end
