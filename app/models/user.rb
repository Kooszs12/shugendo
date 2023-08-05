class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #バリデーション設定
  validates :nickname,
    #文字数制限
    length: { minimum: 1, maximum: 10 },
    #ニックネームの一意性
    uniqueness: true
end
