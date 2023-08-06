class Place < ApplicationRecord

  #バリデーション設定
  validates :type, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :goshuin_status, presence: true
  validates :pet_status, presence: true

  #enum設定
  enum type: { shrine: 0, temple: 1 }
  enum goshuin_status: { note: 0, direct_writing: 1, both: 2, others: 3 }
  enum pet_status: { ok: 0, ng: 1, not_clea: 2 }
end
