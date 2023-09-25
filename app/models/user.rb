class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #バリデーション設定
  validates :nickname, presence: true, length: { maximum: 10 }, uniqueness: true

  # アソシエーション
  has_many :goshuins, dependent: :destroy
  # いいねとのアソシエーション
  has_many :favorites, dependent: :destroy
  # 通報機能とのアソシエーション
  has_many :reports, dependent: :destroy

  #画像カラム
  has_one_attached :image

  #添付される画像がなかった場合のメソッド
  def get_profile_image
    (image.attached?) ? image : 'profile_no_image.png'
  end

  # 定数にメールアドレスを格納
  GUEST_USER_EMAIL = "guest@example.com"

  # ゲストユーザーの生成
  def self.guest
    # find_or_initialize_byはfind_or_create_byとほぼ一緒。ただデータが保存されない
    user = User.find_or_initialize_by(email: GUEST_USER_EMAIL)
    # find_or_initialize_byで判断して、足りない情報を補完する
    user.assign_attributes(password: SecureRandom.urlsafe_base64, nickname: '修験者')
    # find_or_initialize_by使用しているためデータに保存させる必要があるため
    user.save
    # 返り値としてユーザー情報を引き渡す
    user
  end

   # ゲストログイン判断メソッド
  def guest_user?
    email == GUEST_USER_EMAIL
  end

  # is_deletedがfalseならtrueを返すようにしている(退会制限)
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def total_likes_count
    goshuins.sum(&:total_likes)
  end

end