class Admin::GoshuinsController < ApplicationController

  # アクセス制限
  before_action :authenticate_admin!

  # 御朱印編集ページ
  def edit
    # 特定の御朱印データを格納
    @goshuin = Goshuin.find(params[:id])
  end

  # 御朱印更新機能
  def update
    # 特定の御朱印データを格納
    @goshuin = Goshuin.find(params[:id])
    goshuin_params[:user_id] = @goshuin.user_id

    # 更新された場合
    if @goshuin.update(goshuin_params)
      # 成功メッセージ
      redirect_to admin_place_path(@goshuin[:place_id]), info: "編集されました"
    # 失敗した場合
    else
      # 失敗メッセージ
      flash.now[:danger] = "失敗しました"
      # 編集ページへ遷移
      render :edit
    end
  end

  # 御朱印削除機能
  def destroy
    # 特定の御朱印詳細データを格納
    @goshuin = Goshuin.find(params[:id])
    # 削除成功した場合
    if @goshuin.destroy
      redirect_to root_path, info: "削除完了しました"
    # 失敗した場合
    else
      # 失敗メッセージ
      redirect_to root_path, danger: "削除失敗しました"
    end
  end

  private

  def goshuin_params

    params.require(:goshuin).permit(:user_id, :place_id, :message, :price, :visit_day, :goshuin_status, :status, :image)
  end
end
