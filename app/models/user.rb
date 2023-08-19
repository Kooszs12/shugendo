class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #バリデーション設定
  validates :nickname, presence: true, length: { maximum: 10 }, uniqueness: true

  # アソシエーション
  has_many :goshuins
  has_many :favorites, dependent: :destroy

  #画像カラム
  has_one_attached :image

  #添付される画像がなかった場合のメソッド
  def get_goshuin_image
    (image.attached?) ? image : 'profile_no_image'
  end

  # ゲストユーザーの生成
  def guest_sign_in
    # メールアドレス 'guest@example.com' のユーザーを検索または作成
    user = User.find_or_create_by!(email: 'guest@example.com') do |end_user|
      # パスワード生成
      end_user.password = SecureRandom.urlsafe_base64
      # ゲストニックネーム
      end_user.nickname = '修験者'
    end
    # ログイン処理（セッションの管理など）
    sign_in(user)
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

end