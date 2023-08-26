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
  def get_profile_image
    (image.attached?) ? image : 'profile_no_image'
  end

  # ゲストユーザーの生成
  def self.guest
    user = User.find_or_initialize_by(email: 'guest@example.com', nickname: '修験者')
    user.assign_attributes(password: SecureRandom.urlsafe_base64, is_deleted: false)
    user.save
    user
  end

   # ゲストログイン判断メソッド
  def guest_user?
    email == 'guest@example.com'
  end

  # is_deletedがfalseならtrueを返すようにしている(退会制限)
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def total_likes_count
    goshuins.sum(&:total_likes)
  end
  
end