class Goshuin < ApplicationRecord

  # ----- SORT（ソート） -----
  # 新着順
  scope :latest, -> (page, per) { order(created_at: :desc).page(page).per(per) }
  # 古い順
  scope :old, -> (page, per) { order(created_at: :asc).page(page).per(per) }
  # 人気順
  scope :most_liked, ->(page, per) { left_joins(:favorites).select("goshuins.*, COUNT(favorites.id) AS like_count").group("goshuins.id").order("like_count DESC").page(page).per(per) }
  # 参拝日（visit_day）を利用した新着順ソート
  scope :latest_by_visit_day, ->(page, per) { order(visit_day: :desc).page(page).per(per) }
  # 参拝日（visit_day）を利用した古い順ソート
  scope :old_by_visit_day, ->(page, per) { order(visit_day: :asc).page(page).per(per) }

  # バリデーション
  # メッセージの文字数制限
  validates :message, length: { maximum: 250 }
  # 御朱印の種類はなしはNG
  validates :goshuin_status, presence: true

  # アソシエーション
  # ユーザーとのアソシエーション
  belongs_to :user
  # placeとのアソシエーション
  belongs_to :place
  # いいねとのアソシエーション
  has_many :favorites, dependent: :destroy

  #enum設定
  # 寺社種類：{神社＝０　お寺＝１}
  #enum category: { shrine: 0, temple: 1 }
   # 御朱印種類：{書き置き＝０　直書き＝１ 限定＝２ 複数＝３ その他＝４ }
  enum goshuin_status: { note: 0, direct_writing: 1, limited: 2, multiple: 3, other: 4}
   # 公開・非公開：{公開＝０　非公開＝１}
  enum status: { release: 0, private_status: 1 }

  #画像カラム
  has_one_attached :image

  #添付される画像がなかった場合のメソッド
  def get_goshuin_image
    # 御朱印画像が存在しなかった場合gosyuin_no_image.pngを使用
    (image.attached?) ? image : 'gosyuin_no_image.png'
  end

  # ユーザーが投稿に対していいねしたか判断（同じユーザーが同じ投稿にいいねを何度もさせない仕組み）
  def favorited_by?(user)
    # exists?で与えられた条件に合致するレコードが存在するか判断
    favorites.exists?(user_id: user.id) # ユーザーIDが一致するかの条件式
  end

  # 御朱印のいいね総数を獲得メソッド
  def total_likes
    self.favorites.count
  end
end
