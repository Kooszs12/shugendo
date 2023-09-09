class Place < ApplicationRecord

  scope :shrine, -> { where(category: 0).joins(:prefecture).order(prefecture_id: :asc) }
  scope :temple, -> { where(category: 1).joins(:prefecture).order(prefecture_id: :asc) }

  # ----- Narrow down (絞り込み) -----
  scope :prefecture_nd, -> (pref_id, page, per) { where(prefecture_id: pref_id).page(page).per(per) }
  scope :area_nd, -> (area_id, page, per) { joins(:prefecture).where(prefecture: {area_id: area_id})
                                            .order(prefecture_id: :asc).page(page).per(per) }

  # ----- SORT（ソート -----
  scope :prefecture, -> (page, per) { joins(:prefecture).order(prefecture_id: :asc).page(page).per(per) }
  scope :latest, -> (page, per) { order(created_at: :desc).page(page).per(per) }
  scope :old, -> (page, per) { order(created_at: :asc).page(page).per(per) }
  scope :goshuin_count, -> (page, per) { joins(:goshuins).group(:place_id).order('COUNT(goshuins.id) DESC').page(page).per(per) }

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
  validates :postcode, length: { maximum: 7 }
  # 電話番号ハイフンなしバリデーション（１０、１１桁）
  validates :phone_number, length: { maximum: 11 }


  #アソシエーション
  belongs_to :prefecture
  has_many :goshuins, dependent: :destroy
  # 通報機能とのアソシエーション
  has_many :reports, dependent: :destroy

  #enum設定
  # 寺社（shrine: 神社　temple: お寺）
  enum category: { shrine: 0, temple: 1 }
  # 御朱印の種類（note: 書き置き, direct_writing: 直書き, limited: 限定, multiple: 複数, other: その他）
  enum goshuin_status: { note: 0, direct_writing: 1, limited: 2, multiple: 3, other: 4}
  # ペット入場（ok: OK, ng: NG, not_clea: 不明）
  enum pet_status: { ok: 0, ng: 1, not_clea: 2 }

  #imageカラム
  has_one_attached :image

  # プロフィールアイコンが存在するかどうか判断するメソッド
  def get_place_image
    # 存在しなかった場合no_image.pngを使用
    (image.attached?) ? image : 'no_image.png'
  end

# 検索許可
  def self.ransackable_attributes(auth_object = nil)
    # 検索許可するカラム
    ["address", "category", "goshuin_status", "got", "name", "pet_status", "phone_number", "postcode", "sect"]
  end

# アソシエーション先の検索許可
  def self.ransackable_associations(auth_object = nil)
    # 検索許可するカラム
    ["goshuins", "prefecture"]
  end

end
