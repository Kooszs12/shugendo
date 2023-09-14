#ユーザー：寺社コントローラー
class User::PlacesController < ApplicationController
  # 特定のアクセス制限解除
  before_action :authenticate_user!, except: [:index, :show]

  # 寺社投稿ページ
  def new
    # 空の変数作成
    @place = Place.new
  end

  # 寺社投稿機能
  def create
    #空の変数作成
    @place = Place.new(place_params)
    #保存が成功したら
    if @place.save
      # 作成した寺社詳細ページへ遷移
      redirect_to place_path(@place), info: "投稿されました"
    #失敗した場合
    else
      # 失敗メッセージ
      flash.now[:danger] = "失敗しました"
      # 新規投稿ページへ遷移
      render :new
    end
  end

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

  # 寺社詳細ページ（関連した御朱印の表示）
  def show
    page = params[:page]
    per = 5
    # 特定の寺社詳細データ格納
    @place = Place.find(params[:id])
    # 公開された御朱印のデータを取得し、ページネーションを適用（１ページ件表示）
    @goshuins = @place.goshuins.where(status: "release").order(created_at: :desc).page(params[:page]).per(5)
    @goshuin_names = @goshuins.map { |goshuin| goshuin.place.name }
    @goshuin_users = @goshuins.map { |goshuin| goshuin.user.nickname }
    @goshuin_prefectures = @goshuins.map { |goshuin| goshuin.place.prefecture }
    # ソート条件に基づいてソートされた場所を返す
    case params[:sort_option]
      when 'latest'
        @goshuins = @place.goshuins.latest(page, per)
      when 'old'
        @goshuins = @place.goshuins.old(page, per)
      # いいねの多い順
      when 'most_liked'
        @goshuins = @place.goshuins.most_liked(page, per)
      else
        @goshuins = @place.goshuins.page(page).per(per)
    end
  end

  # 寺社編集ページ
  def edit
    # 特定の寺社詳細データ格納
    @place = Place.find(params[:id])
  end

  # 寺社更新機能
  def update
    # 特定の寺社詳細ページを格納
    @place = Place.find(params[:id])
    # 更新成功した場合
    if @place.update(place_params)
        # 更新に成功した寺社詳細ページへ遷移
        redirect_to place_path(@place), info: "編集されました"
    # 失敗した場合
    else
      # 失敗メッセージ
      flash.now[:danger] = "失敗しました"
      # 失敗した寺社編集ページへ遷移
      render :edit
    end
  end

   private

  def place_params
    params.require(:place).permit(
      :prefecture_id,
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
