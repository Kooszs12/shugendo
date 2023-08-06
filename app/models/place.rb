class Place < ApplicationRecord

  #バリデーション設定
  validates :type, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :goshuin_status, presence: true
  validates :pet_status, presence: true

end
