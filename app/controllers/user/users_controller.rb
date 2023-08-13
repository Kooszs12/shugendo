class User::UsersController < ApplicationController

  def show
    @user = current_user
    @goshuins = @user.goshuins.page(params[:page]).per(10) # ページネーションを適用（１ページ１０件表示）
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path(@user) # 関連する寺社の詳細ページに遷移
      flash[:notice] = "編集されました"
    else
      flash.now[:alert] = "失敗しました"
      render :edit
    end
  end

end
