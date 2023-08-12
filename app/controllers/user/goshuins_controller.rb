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
    # 神社date
    @jinja= Place.where(category: 0)
    # お寺data
    @otera= Place.where(category: 1)
    if @goshuin.save
      flash[:notice] = "投稿されました"
      redirect_to goshuin_path(@goshuin)
    #失敗したら
    else
      flash.now[:alert] = "失敗しました"
      render :new
    end
  end

  def index
    @goshuins = Goshuin.all
  end

  def show
    @goshuin = Goshuin.find(params[:id])
  end

  def edit
    @goshuin = Goshuin.find(params[:id])
  end

  def update
    @goshuin = Goshuin.find(params[:id])
    if @goshuin.update(goshuin_paramus)
      redirect_to place_path(@goshuin)
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
    params.require(:goshuin).permit(:user_id, :place_id, :message, :price, :visit_day, :category)
  end


end
