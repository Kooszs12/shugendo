#管理者：寺社コントローラー
class Admin::PlacesController < ApplicationController

  # アクセス制限
  before_action :authenticate_admin!

  # 寺社新規投稿ページ
  def new
    # 空の変数を作成
    @place = Place.new
  end

  # 寺社新規投稿機能
  def create
    #空の変数作成
    @place = Place.new(place_params)
    #保存が成功したら
    if @place.save
      # 寺社詳細ページへ遷移
      redirect_to admin_place_path(@place), info: "投稿されました"
    #失敗したら
    else
      # 失敗メッセージ
      flash.now[:danger] = "失敗しました"
      # 新規投稿ページへ遷移
      render :new
    end
  end

  # 寺社一覧ページ
  # 寺社一覧ページ
  def index
    page = params[:page]
    per = 5

    if params[:prefecture_id]
      @places = Place.prefecture_nd(params[:prefecture_id], page, per)
    elsif params[:area_id]
      @places = Place.area_nd(params[:area_id], page, per)
    else
      # ソート条件に基づいてソートされた場所を返す
      case params[:sort_option]
        when 'prefecture'
          @places = Place.prefecture(page, per)
        when 'latest'
          @places = Place.latest(page, per)
        when 'old'
          @places = Place.old(page, per)
        when 'goshuin_count'
          @places = Place.goshuin_count(page, per)
        else
          @places = Place.page(page).per(per)
      end
    end

    @shrine = @places.where(category: "shrine").order(created_at: :desc).page(page).per(5)
    @temple = @places.where(category: "temple").order(created_at: :desc).page(page).per(5)

  end

  # 寺社詳細ページ
  def show
    page = params[:page]
    per = 5
    # 特定の寺社データ格納
    @place = Place.find(params[:id])
    # 上記の寺社が持つ御朱印のデータを格納
    @goshuins = @place.goshuins.where(status: "release").page(page).per(per)
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }

    # ソート条件に基づいてソートされた場所を返す
    case params[:sort_option]
     # 新着順
      when 'latest'
        @goshuins = @goshuins.latest(page, per)
      # 古い順
      when 'old'
        @goshuins = @goshuins.old(page, per)
      # いいねの多い順
      when 'most_liked'
        @goshuins = @goshuins.most_liked(page, per)
      else
        @goshuins = @goshuins.order(created_at: :desc).page(page).per(per)
    end
  end

  # 編集ページ
  def edit
    # 特定の寺社のデータを格納
    @place = Place.find(params[:id])
  end

  # 更新機能
  def update
    # 特定の寺社データを格納
    @place = Place.find(params[:id])
    @report = Report.find_by(place_id: params[:id])
    # 更新に成功したら
    if @place.update(place_params)
        # @reportがnilか判断
        if @report.present?
          # 寺社が更新されたらレポートを削除
          @report.destroy
        end
        # 更新された寺社詳細ページへ遷移
        redirect_to admin_place_path(@place), info: "編集されました"
    else
      # 失敗メッセージ
      flash.now[:danger] = "失敗しました"
      # 失敗した寺社編集ページへ遷移
      render :edit
    end
  end

  # 削除機能
  def destroy
    # 特定の寺社データを格納
    @place = Place.find(params[:id])
    # 上記データを削除
    @place.destroy
    # 寺社一覧ページへ遷移
    redirect_to admin_places_path, info: "削除しました"
  end

   private

  def place_params
    params.require(:place).permit(
    :prefecture_id,
    :user_id,
    :admin_id,
    :category,
    :name,
    :address,
    :postcode,
    :phone_number,
    :got,
    :sect,
    :goshuin_status,
    :pet_status,
    :image,
    :fee,
    :start_time,
    :end_time
    ).merge(
        # ユーザーIDが存在するかどうか判断。存在しなかった場合nil
        user_id: user_signed_in? ? current_user.id : nil,
        # アドミンIDが存在するかどうか判断。存在しなかった場合nil
        admin_id: admin_signed_in? ? current_admin.id : nil
      )
  end

end