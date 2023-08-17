class Goshuin < ApplicationRecord

  # バリデーション
  # メッセージの文字数制限
  validates :message, length: { maximum: 200 }
  # 御朱印の種類はなしはNG
  validates :goshuin_status, presence: true

  # アソシエーション
  belongs_to :user
  belongs_to :place

  #enum設定
  # 寺社種類：{神社＝０　お寺＝１}
  enum category: { shrine: 0, temple: 1 }
   # 御朱印種類：{書き置き＝０　直書き＝１ 限定＝２ 複数＝３ その他＝４ }
  enum goshuin_status: { note: 0, direct_writing: 1, limited: 2, multiple: 3, other: 4}
   # 公開・非公開：{公開＝０　非公開＝１}
  enum status: { release: 0, private_status: 1 }

  #画像カラム
  has_one_attached :image

  #添付される画像がなかった場合のメソッド
  def get_goshuin_image
    (image.attached?) ? image : 'gosyuin_no_image'
  end

end
