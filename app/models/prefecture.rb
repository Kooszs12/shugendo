class Prefecture < ApplicationRecord

  #バリデーション設定(いらない？)
  validates :name, presence: true

  #アソシエーション(アソシエーションを記述するとバリデーションが設定される)
  #都道府県に対して地方が１：N
  belongs_to :area
  has_many :places

end
