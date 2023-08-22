class Prefecture < ApplicationRecord

  #バリデーション設定(いらない？)
  validates :name, presence: true

  #アソシエーション(アソシエーションを記述するとバリデーションが設定される)
  belongs_to :area
  has_many :places
  def self.ransackable_attributes(auth_object = nil)
    ["area_id", "created_at", "id", "name", "updated_at"]
  end
end
