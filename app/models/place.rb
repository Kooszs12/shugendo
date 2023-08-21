class Place < ApplicationRecord

  #バリデーション設定
  # カテゴリーラジオボタンバリデーション
  validates :category, presence: true
  # 寺社名バリデーション
  validates :name, presence: true, length: { maximum: 20 }
  # 住所バリデーション
  validates :address, presence: true, length: { maximum: 50 }
  # 御朱印の種類ラジオボタンバリデーション
  validates :goshuin_status, presence: true
  # ペット状況ラジオボタンバリデーション
  validates :pet_status, presence: true
  # 郵便番号ハイフンありバリデーション（７桁）
  validates :postcode, format: { with: /\A\d{3}[-]\d{4}\z/ }
  # 電話番号ハイフンなしバリデーション（１０、１１桁）
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }


  #アソシエーション
  belongs_to :prefecture
  has_many :goshuins

  #enum設定
  enum category: { shrine: 0, temple: 1 }
  enum goshuin_status: { note: 0, direct_writing: 1, limited: 2, multiple: 3, other: 4}
  enum pet_status: { ok: 0, ng: 1, not_clea: 2 }

  #imageカラム
  has_one_attached :image

  #添付される画像がなかった場合のメソッド
  def get_place_image
    (image.attached?) ? image : 'no_image'
  end

# 検索許可
  def self.ransackable_attributes(auth_object = nil)
    ["address", "category", "goshuin_status", "got", "name", "pet_status", "phone_number", "postcode", "sect"]
  end

# アソシエーション先の検索許可
  def self.ransackable_associations(auth_object = nil)
    ["goshuins", "prefecture"]
  end

end
