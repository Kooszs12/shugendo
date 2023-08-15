class User::SearchesController < ApplicationController

  def search
    #検索した名前をViewで表示させるための変数
    @word = (params[:q][:name_cont])
    @q = Place.ransack(params[:q])
    @place = @q.result(distinct: true)
  end

end