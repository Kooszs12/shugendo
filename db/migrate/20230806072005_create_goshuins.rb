class CreateGoshuins < ActiveRecord::Migration[6.1]

  def change
    create_table :goshuins do |t|

      #referencesでFKが自動生成され
      # Userとのアソシエーション
      t.references :user, null: false, foreign_key: true
      # Placeとのアソシエーション
      t.references :place, null: false, foreign_key: true
      # 御朱印料金カラム
      t.integer :price, default: 0 # 金額のカラムは, defaultを０にしておいた方がいい
      # 御朱印の種類カラム
      t.integer :goshuin_status, null: false
      # 投稿するメッセージカラム
      t.string :message
      # 参拝日カラム
      t.date :visit_day
      # 投稿公開・非公開カラム
      t.integer :status, null: false, default: 0 # enum

      t.timestamps
    end
  end
end