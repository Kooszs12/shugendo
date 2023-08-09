class User::HomesController < ApplicationController
  def top
    @places = Place.all # 例として全ての場所を取得するコードを記述
  end
end
