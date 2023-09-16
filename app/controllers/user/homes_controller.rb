# ユーザー＆アドミンTopページ
class User::HomesController < ApplicationController

  def top
    page = params[:page]
    per = 5
    # 公開された御朱印のデータを取得し新着順に表示、ページネーションを適用（１ページ１０件表示）
    @goshuins = Goshuin.where(status: "release").page(page).per(per)
    # byebug
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    # ソート条件に基づいてソートされた場所を返す
    case params[:sort_option]
      when 'latest'
        @goshuins = @goshuins.latest(page, per)
      when 'old'
        @goshuins = @goshuins.old(page, per)
      when 'most_liked'
        @goshuins = @goshuins.most_liked(page, per)
      else
        @goshuins = @goshuins.order(created_at: :desc).page(page).per(per)
    end
  end

end
