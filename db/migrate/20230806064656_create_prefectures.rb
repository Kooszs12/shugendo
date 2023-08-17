class CreatePrefectures < ActiveRecord::Migration[6.1]

  def change
    create_table :prefectures do |t|

    # areaとのアソシエーション
    t.references :area, null: false, foreign_key: true
    # 都道府県名カラム
    t.string :name, null: false

      t.timestamps
    end
  end
end
