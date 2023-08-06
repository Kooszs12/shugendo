class Area < ApplicationRecord

  #バリデーション設定(いらない？)
  validates :name, presence: true

  #アソシエーション
  #都道府県に対して地方が１：N
  has_many :prefectures, dependent: :destroy

end
