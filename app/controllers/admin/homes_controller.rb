class Admin::HomesController < ApplicationController

  # アクセス制限
  before_action :authenticate_admin!

  def top
    # 公開された御朱印のデータを取得し新着データ順に表示、ページネーションを適用（１ページ5件表示）
    @goshuins = Goshuin.where(status: "release").order(created_at: :desc).page(params[:page]).per(5)
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    # ソート条件に基づいてソートされた場所を返す
    case params[:sort_option]
      # 新着順
      when 'latest'
        @goshuins = Goshuin.latest(page, per)
      # 古い順
      when 'old'
        @goshuins = Goshuin.old(page, per)
      # いいねの多い順
      when 'most_liked'
        @goshuins = Goshuin.most_liked(page, per)
      # デフォルト
      else
        @goshuins = Goshuin.page(page).per(per)
    end
    # 閲覧するviewは同じなのでユーザーのTop画面へ遷移
    render 'user/homes/top'
  end

end
