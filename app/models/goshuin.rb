class Goshuin < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :place

   #画像カラム
  has_one_attached :image

  #添付される画像がなかった場合のメソッド
  def get_gosyuin_image
    (image.attached?) ? image : 'gosyuin_no_image'
  end
end
