class Report < ApplicationRecord

  #アソシエーション
  belongs_to :user
  belongs_to :place

end