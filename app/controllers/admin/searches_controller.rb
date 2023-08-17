class Admin::SearchesController < ApplicationController

  def search
    # Ransackを使用してクエリを構築
    @q = Place.ransack(params[:q]) # 検索フォームから送られてきたパラメータ
    # クエリを実行して検索結果を取得し、重複を除いて @places に格納
    @places = @q.result(distinct: true)

    # 検索結果の有無による条件分岐
    if @places.empty? # 空かどうか判断している
      # 検索キーワードを＠wordに格納
      @word = params.dig(:q, :name_cont)
    else
      @word = params.dig(:q, :name_cont)
      @result_present = true  # 検索結果がある場合のフラグ
    end
  end

end
