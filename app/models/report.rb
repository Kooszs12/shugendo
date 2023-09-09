class Report < ApplicationRecord

  #アソシエーション
  belongs_to :user
  belongs_to :place

  #enum設定
  # 通報機能（waiting: 未対応 finish: 対応済み）
  enum status: { waiting: 0, finish: 1 }

end
