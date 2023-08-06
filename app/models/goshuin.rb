class Goshuin < ApplicationRecord

  #バリデーション設定
  validates :nickname, presence: true

end
