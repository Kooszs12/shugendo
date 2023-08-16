class User::SearchesController < ApplicationController

  def search
    @q = Place.ransack(params[:q])
    @places = @q.result(distinct: true)  # 変数名を @places に変更

    # @places が空かどうかの条件分岐を行う
    if @places.empty?
      @word = params.dig(:q, :name_cont)
    else
      @word = params.dig(:q, :name_cont)
      @result_present = true  # 検索結果がある場合のフラグ
    end
  end

end