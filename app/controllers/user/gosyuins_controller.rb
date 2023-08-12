# 御朱印コントローラー
class User::GosyuinsController < ApplicationController

  before_action :authenticate_user!

  def new
    @gosyuin = Gosyuin.new
  end

  def create
    @gosyuin =Gosyuin.new(gosyuin_params)
    if @gosyuin.save
      redirect_to gosyuin_path(@gosyuin)
      flash[:notice] = "投稿されました"
    #失敗したら
    else
      flash.now[:alert] = "失敗しました"
      render :new
    end
  end

  def index
    @gosyuins = Gosyuin.all
  end

  def show
    @gosyuin = Gosyuin.find(params[:id])
  end

  def edit
    @gosyuin = Gosyuin.find(params[:id])
  end

  def update
    @gosyuin = Gosyuin.find(params[:id])
    if @gosyuin.update(gosyuin_paramus)
      redirect_to gosyuin_path(@gosyuin)
      flash[:notice] = "編集されました"
    else
      flash.now[:alert] = "失敗しました"
      render :edit
    end
  end

  def destroy
     @gosyuin = Gosyuin.find(params[:id])
     @gosyuin.destroy
     redirect_to gosyuin_path

  end

end
