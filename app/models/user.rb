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
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      # パスワード生成
      user.password = SecureRandom.urlsafe_base64
      # ゲストニックネーム
      user.nickname = '修験者'
    end
  end

  # is_deletedがfalseならtrueを返すようにしている(退会制限)
  def active_for_authentication?
    super && (is_deleted == false)
  end

end