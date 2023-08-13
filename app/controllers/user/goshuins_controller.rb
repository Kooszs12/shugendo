class User::GoshuinsController < ApplicationController

  before_action :authenticate_user!

  def new
    @goshuin = Goshuin.new
    # 神社data
    @jinja= Place.where(category: 0)
    # お寺data
    @otera= Place.where(category: 1)
  end

  def create
    @goshuin = Goshuin.new(goshuin_params)

    if @goshuin.save
      flash[:notice] = "投稿されました"
      redirect_to place_path(@goshuin.place)  # 関連する寺社の詳細ページに遷移
    else
      flash.now[:alert] = "失敗しました"
      render :new
    end
  end

  def index
    @goshuins = Goshuin.all
  end

  def edit
    @goshuin = Goshuin.find(params[:id])
    @jinja = Place.where(category: 0) # 神社data
    @otera = Place.where(category: 1) # お寺data
  end

  def update
    @goshuin = Goshuin.find(params[:id])

    @jinja = Place.where(category: 0) # 神社data
    @otera = Place.where(category: 1) # お寺data
    if @goshuin.update(goshuin_params)
      redirect_to place_path(@goshuin.place) # 関連する寺社の詳細ページに遷移
      flash[:notice] = "編集されました"
    else
      flash.now[:alert] = "失敗しました"
      render :edit
    end
  end

  def destroy
    @goshuin = Goshuin.find(params[:id])
    @goshuin.destroy
    flash[:notice] = "削除が完了しました。"
    redirect_to gosyuin_path
  end

  private

  def goshuin_params
    params.require(:goshuin).permit(:user_id, :place_id, :message, :price, :visit_day)
  end


end
