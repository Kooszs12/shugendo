class User::SearchesController < ApplicationController

  def search
    # Ransackを使用してクエリを構築
    @q = Place.ransack(params[:q]) # 検索フォームから送られてきたパラメータ
    # クエリを実行して検索結果を取得し、重複を除いて @places に格納
    @places = @q.result(distinct: true)
    # 検索状況をviewで表示させるための変数
    @selected_conditions = params[:q] || {}  # 選択した検索条件を格納する変数

    # 検索結果の有無による条件分岐
    if @places.empty? # 空かどうか判断している
      # 検索キーワードを＠wordに格納
      @word = params.dig(:q, :name_or_address_or_postcode_or_phone_number_cont)
    else
      @word = params.dig(:q, :name_or_address_or_postcode_or_phone_number_cont)
      @result_present = true  # 検索結果がある場合のフラグ
    end
  end

  def your_action
    # ここで初期状態を設定
    @selected_conditions = {} # 例: 初期状態では空のハッシュ
  end

end