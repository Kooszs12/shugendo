# ユーザー＆アドミンTopページ
class User::HomesController < ApplicationController

  def top
    page = params[:page]
    per = 5
    # 公開された御朱印のデータを取得し新着順に表示、ページネーションを適用（１ページ１０件表示）
    @goshuins = Goshuin.where(status: "release").order(created_at: :desc).page(params[:page]).per(5)
    # byebug
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    # ソート条件に基づいてソートされた場所を返す
    case params[:sort_option]
      when 'latest'
        @goshuins = Goshuin.latest(page, per)
      when 'old'
        @goshuins = Goshuin.old(page, per)
      else
        @goshuins = Goshuin.page(page).per(per)
    end
  end

end
