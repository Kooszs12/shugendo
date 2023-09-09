class Report < ApplicationRecord

  #アソシエーション
  belongs_to :user
  belongs_to :place

  #enum設定
  # 通報機能（waiting: 未対応　keep: 保留　finish: 対応済み）
  enum status: { waiting: 0, keep: 1, finish: 2 }

end
