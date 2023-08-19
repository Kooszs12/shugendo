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

end