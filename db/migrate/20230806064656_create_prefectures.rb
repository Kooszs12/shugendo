class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|

      t.references :area, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
