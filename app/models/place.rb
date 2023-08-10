class Place < ApplicationRecord

  #バリデーション設定
  validates :category, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :goshuin_status, presence: true
  validates :pet_status, presence: true

  #アソシエーション
  belongs_to :prefecture

  #enum設定
  enum category: { shrine: 0, temple: 1 }
  enum goshuin_status: { note: 0, direct_writing: 1, both: 2, others: 3 }
  enum pet_status: { ok: 0, ng: 1, not_clea: 2 }

  #imageカラム
  has_one_attached :image

  #添付される画像がなかった場合のメソッド
  def get_place_image
    (image.attached?) ? image : 'no_image'
  end

end
