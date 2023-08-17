class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      # Prefectureとのアソシエーション
      t.references :prefecture, null: false, foreign_key: true
      # Userとのアソシエーション
      t.integer :user_id #拡張性を考慮
      # Adminとのアソシエーション
      t.integer :admin_id #拡張性を考慮
      # 御朱印の種類カラム
      t.integer :category, null: false, default: 0 # enum
      # 寺社名カラム
      t.string :name, null: false
      # 市区町村からの住所カラム
      t.string :address, null: false
      # 郵便番号カラム
      t.string :postcode
      # 電話番号カラム
      t.string :phone_number
      # 神様カラム
      t.string :got
      # 宗派カラム
      t.string :sect
      # 拝観料カラム
      t.integer :fee, default: 0 # 金額のカラムは, defaultを０にしておいた方がいい
      # 御朱印の種類カラム
      t.integer :goshuin_status, null: false #enum
      # ペットカラム
      t.integer :pet_status, null: false #enum

      t.timestamps
    end
  end
end
