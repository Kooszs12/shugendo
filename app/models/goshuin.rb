class Goshuin < ApplicationRecord

  # バリデーション
  validates :message, length: { maximum: 200 }

  # アソシエーション
  belongs_to :user
  belongs_to :place

  #enum設定
  enum category: { shrine: 0, temple: 1 }

  #画像カラム
  has_one_attached :image

  #添付される画像がなかった場合のメソッド
  def get_goshuin_image
    (image.attached?) ? image : 'gosyuin_no_image'
  end

end
